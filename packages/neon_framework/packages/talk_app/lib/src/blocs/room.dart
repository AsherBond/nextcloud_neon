import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:dynamite_runtime/http_client.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:neon_framework/blocs.dart';
import 'package:neon_framework/models.dart';
import 'package:neon_framework/utils.dart';
import 'package:nextcloud/spreed.dart' as spreed;
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:talk_app/src/blocs/talk.dart';
import 'package:talk_app/src/utils/helpers.dart';

/// Manages the state of a Talk room.
@sealed
abstract class TalkRoomBloc implements InteractiveBloc {
  /// Creates a new Talk room bloc.
  factory TalkRoomBloc({
    required TalkBloc talkBloc,
    required Account account,
    required spreed.Room room,
  }) = _TalkRoomBloc;

  /// Sends a new text message to the room.
  void sendMessage(String message);

  /// Adds an emoji [reaction] to the [message].
  void addReaction(spreed.$ChatMessageInterface message, String reaction);

  /// Removes an emoji [reaction] from the [message].
  void removeReaction(spreed.$ChatMessageInterface message, String reaction);

  /// Loads the emoji reactions for the [message].
  void loadReactions(spreed.$ChatMessageInterface message);

  /// Sets a [chatMessage] as the message to [replyTo].
  void setReplyChatMessage(spreed.$ChatMessageInterface chatMessage);

  /// Sets a [chatMessage] as the message to [editing].
  void setEditChatMessage(spreed.$ChatMessageInterface chatMessage);

  /// Removes the current [replyTo] chat message.
  void removeReplyChatMessage();

  /// Removes the current [editing] chat message.
  void removeEditChatMessage();

  /// Deletes a chat messages.
  void deleteMessage(spreed.$ChatMessageInterface chatMessage);

  /// The current room data.
  BehaviorSubject<Result<spreed.Room>> get room;

  /// The messages in this room.
  BehaviorSubject<Result<BuiltList<spreed.ChatMessageWithParent>>> get messages;

  /// {@template TalkRoomBloc.lastCommonRead}
  /// The last message ID that was read by everyone with read-privacy set to public.
  /// {@endtemplate}
  BehaviorSubject<int> get lastCommonRead;

  /// Map of emoji reactions for the [messages].
  BehaviorSubject<BuiltMap<int, BuiltMap<String, BuiltList<spreed.Reaction>>>> get reactions;

  /// Current chat message to reply to.
  BehaviorSubject<spreed.$ChatMessageInterface?> get replyTo;

  /// Current chat message that is edited.
  BehaviorSubject<spreed.$ChatMessageInterface?> get editing;
}

class _TalkRoomBloc extends InteractiveBloc implements TalkRoomBloc {
  _TalkRoomBloc({
    required this.talkBloc,
    required this.account,
    required spreed.Room room,
  })  : room = BehaviorSubject.seeded(Result.success(room)),
        token = room.token {
    messages.listen((result) {
      assert(
        result.data?.where((message) => message.isHidden).isEmpty ?? true,
        'No hidden messages should be emitted',
      );

      if (!result.hasSuccessfulData) {
        return;
      }

      final lastMessage = result.requireData.firstOrNull;
      if (lastMessage == null) {
        return;
      }

      final value = this.room.value;
      this.room.add(
            value.copyWith(
              data: value.requireData.rebuild(
                (b) => b
                  ..lastActivity = lastMessage.timestamp
                  ..lastMessage = (
                    baseMessage: null,
                    builtListNever: null,
                    // TODO: This manual conversion is only necessary because the interface isn't used everywhere: https://github.com/nextcloud/neon/issues/1995
                    chatMessage: spreed.ChatMessage.fromJson(lastMessage.toJson()),
                  )
                  ..lastCommonReadMessage = lastCommonRead.valueOrNull
                  // The following fields can be set because we know that any updates to the messages (sending/polling) updates the last read message.
                  ..lastReadMessage = lastMessage.id
                  ..unreadMention = false
                  ..unreadMentionDirect = false
                  ..unreadMessages = 0,
              ),
            ),
          );
    });

    this.room.listen((result) {
      if (result.hasSuccessfulData) {
        talkBloc.updateRoom(result.requireData);
      }
    });

    unawaited(() async {
      while (pollLoop) {
        if (lastKnownMessageId == null) {
          log.fine('Last message ID not known');
          await Future<void>.delayed(const Duration(seconds: 1));
          continue;
        }

        log.info('Polling messages');

        try {
          final response = await account.client.spreed.chat.receiveMessages(
            token: token,
            lookIntoFuture: spreed.ChatReceiveMessagesLookIntoFuture.$1,
            includeLastKnown: spreed.ChatReceiveMessagesIncludeLastKnown.$0,
            lastKnownMessageId: lastKnownMessageId,
            limit: 100,
          );

          updateLastCommonRead(response.headers.xChatLastCommonRead);
          updateLastKnownMessageId(response.body.ocs.data.lastOrNull?.id);
          prependMessages(response.body.ocs.data.reversed);
        } catch (error, stackTrace) {
          if (error case DynamiteStatusCodeException(statusCode: 304)) {
            log.info('Polling returned no new messages');
          } else if (error is! TimeoutException) {
            log.info(
              'Error while waiting for new chat messages',
              error,
              stackTrace,
            );

            // Don't spam the server if the error persists
            await Future<void>.delayed(const Duration(seconds: 10));
          }
        }
      }

      log.info('Polling messages done');
    }());

    unawaited(refresh());
  }

  @override
  final log = Logger('TalkRoomBloc');

  final TalkBloc talkBloc;
  final Account account;
  final String token;
  int? lastKnownMessageId;
  bool pollLoop = true;

  @override
  final BehaviorSubject<Result<spreed.Room>> room;

  @override
  final messages = BehaviorSubject();

  @override
  final lastCommonRead = BehaviorSubject();

  @override
  final reactions = BehaviorSubject.seeded(BuiltMap());

  @override
  final replyTo = BehaviorSubject.seeded(null);

  @override
  final editing = BehaviorSubject.seeded(null);

  @override
  void dispose() {
    pollLoop = false;
    unawaited(account.client.spreed.room.leaveRoom(token: token));

    unawaited(room.close());
    unawaited(messages.close());
    unawaited(lastCommonRead.close());
    unawaited(reactions.close());
    unawaited(replyTo.close());
    unawaited(editing.close());
    super.dispose();
  }

  @override
  Future<void> refresh() async {
    await Future.wait([
      RequestManager.instance.wrap(
        account: account,
        subject: room,
        getRequest: () => account.client.spreed.room.$joinRoom_Request(
          token: token,
        ),
        converter: ResponseConverter(account.client.spreed.room.$joinRoom_Serializer()),
        unwrap: (response) => response.body.ocs.data,
      ),
      RequestManager.instance.wrap(
        account: account,
        subject: messages,
        getRequest: () => account.client.spreed.chat.$receiveMessages_Request(
          token: token,
          lookIntoFuture: spreed.ChatReceiveMessagesLookIntoFuture.$0,
          includeLastKnown: spreed.ChatReceiveMessagesIncludeLastKnown.$0,
          limit: 100,
        ),
        converter: ResponseConverter(account.client.spreed.chat.$receiveMessages_Serializer()),
        unwrap: (response) {
          updateLastCommonRead(response.headers.xChatLastCommonRead);
          updateLastKnownMessageId(response.body.ocs.data.firstOrNull?.id);

          return response.body.ocs.data.rebuild((b) {
            b.removeWhere((message) => message.isHidden);
          });
        },
      ),
    ]);
  }

  @override
  Future<void> sendMessage(String message) async {
    await wrapAction(
      () async {
        late spreed.ChatMessageWithParent? m;
        late String? lastCommonRead;

        final editingId = editing.value?.id;
        if (editingId != null) {
          editing.add(null);

          final response = await account.client.spreed.chat.editMessage(
            token: token,
            messageId: editingId,
            $body: spreed.ChatEditMessageRequestApplicationJson(
              (b) => b.message = message,
            ),
          );

          m = response.body.ocs.data;
          lastCommonRead = response.headers.xChatLastCommonRead;
        } else {
          final replyToId = replyTo.value?.id;
          replyTo.add(null);

          final response = await account.client.spreed.chat.sendMessage(
            token: token,
            $body: spreed.ChatSendMessageRequestApplicationJson(
              (b) {
                b.message = message;
                if (replyToId != null) {
                  b.replyTo = replyToId;
                }
              },
            ),
          );

          m = response.body.ocs.data;
          lastCommonRead = response.headers.xChatLastCommonRead;
        }

        updateLastCommonRead(lastCommonRead);
        if (m != null) {
          updateLastKnownMessageId(m.id);
          prependMessages([m]);
        }
      },
      refresh: () async {},
    );
  }

  @override
  Future<void> addReaction(spreed.$ChatMessageInterface message, String reaction) async {
    await wrapAction(
      () async {
        final response = await account.client.spreed.reaction.react(
          token: token,
          messageId: message.id,
          $body: spreed.ReactionReactRequestApplicationJson(
            (b) => b..reaction = reaction,
          ),
        );

        updateReactions(
          message.id,
          response.body.ocs.data,
        );
      },
      refresh: () async {},
    );
  }

  @override
  Future<void> removeReaction(spreed.$ChatMessageInterface message, String reaction) async {
    await wrapAction(
      () async {
        final response = await account.client.spreed.reaction.delete(
          token: token,
          messageId: message.id,
          reaction: reaction,
        );

        updateReactions(
          message.id,
          response.body.ocs.data,
        );
      },
      refresh: () async {},
    );
  }

  @override
  Future<void> loadReactions(spreed.$ChatMessageInterface message) async {
    if (reactions.value.containsKey(message.id)) {
      return;
    }

    await wrapAction(
      () async {
        final response = await account.client.spreed.reaction.getReactions(
          token: token,
          messageId: message.id,
        );

        updateReactions(
          message.id,
          response.body.ocs.data,
        );
      },
      refresh: () async {},
    );
  }

  @override
  void setReplyChatMessage(spreed.$ChatMessageInterface chatMessage) {
    editing.add(null);
    replyTo.add(chatMessage);
  }

  @override
  void removeReplyChatMessage() {
    replyTo.add(null);
  }

  @override
  void setEditChatMessage(spreed.$ChatMessageInterface chatMessage) {
    replyTo.add(null);
    editing.add(chatMessage);
  }

  @override
  void removeEditChatMessage() {
    editing.add(null);
  }

  @override
  Future<void> deleteMessage(spreed.$ChatMessageInterface chatMessage) async {
    await wrapAction(
      () async {
        final response = await account.client.spreed.chat.deleteMessage(
          token: token,
          messageId: chatMessage.id,
        );

        updateLastCommonRead(response.headers.xChatLastCommonRead);

        final m = response.body.ocs.data;
        updateLastKnownMessageId(m.id);

        prependMessages([m]);
      },
      refresh: () async {},
    );
  }

  void updateLastCommonRead(String? header) {
    if (header != null) {
      final id = int.parse(header);
      log.info('Updated last common read: $id');
      lastCommonRead.add(id);
    }
  }

  void updateLastKnownMessageId(int? id) {
    if (id != null && (lastKnownMessageId == null || id > lastKnownMessageId!)) {
      log.info('Updated last known message id: $id');
      lastKnownMessageId = id;
    }
  }

  void prependMessages(Iterable<spreed.ChatMessageWithParent> newMessages) {
    final builder = ListBuilder<spreed.ChatMessageWithParent>(newMessages);

    if (messages.hasValue) {
      final result = messages.value;
      if (result.hasData) {
        final lastMessageID = newMessages.last.id;
        builder.addAll(result.requireData.where((message) => message.id < lastMessageID));
      }

      // Skip messages without parents as we can't know which message should be updated
      final newHiddenMessages =
          newMessages.where((newMessage) => newMessage.isHidden && newMessage.parent != null).toBuiltList();

      if (newHiddenMessages.isNotEmpty) {
        builder.map((message) {
          // If there are multiple messages updating the same parent message only the newest is applied because it already contains all values
          for (final newHiddenMessage in newHiddenMessages) {
            final hiddenMessageParent = newHiddenMessage.parent!;
            final hiddenMessageParentID =
                hiddenMessageParent.chatMessage?.id ?? hiddenMessageParent.deletedChatMessage!.id;

            if (message.id == hiddenMessageParentID) {
              // Conversion from ChatMessage to ChatMessageWithParent is necessary because parent messages can't have parents of their own
              return spreed.ChatMessageWithParent.fromJson(hiddenMessageParent.toJson()! as Map<String, dynamic>);
            }

            final messageParentID = message.parent?.chatMessage?.id ?? message.parent?.deletedChatMessage?.id;
            if (messageParentID == hiddenMessageParentID) {
              return message.rebuild((b) => b.parent = hiddenMessageParent);
            }
          }

          return message;
        });
      }

      builder.removeWhere((message) => message.isHidden);

      messages.add(
        result.copyWith(
          data: builder.build(),
        ),
      );
    } else {
      builder.removeWhere((message) => message.isHidden);

      messages.add(Result.success(builder.build()));
    }
  }

  void updateReactions(int messageId, BuiltMap<String, BuiltList<spreed.Reaction>> reactions) {
    this.reactions.add(
          this.reactions.value.rebuild((b) {
            b[messageId] = reactions;
          }),
        );

    updateMessage(
      messageId,
      (b) => b
        ..reactions.update((b) {
          b.clear();

          for (final entry in reactions.entries) {
            b[entry.key] = entry.value.length;
          }
        })
        ..reactionsSelf.update((b) {
          b.clear();

          for (final entry in reactions.entries) {
            if (entry.value.where((r) => r.actorId == account.username).isNotEmpty) {
              b.add(entry.key);
            }
          }
        }),
    );
  }

  void updateMessage(
    int messageId,
    spreed.ChatMessageWithParentBuilder Function(spreed.ChatMessageWithParentBuilder b) updates,
  ) {
    final result = messages.valueOrNull;
    if (result == null) {
      return;
    }
    final data = result.data;
    if (data == null) {
      return;
    }

    messages.add(
      result.copyWith(
        data: data.rebuild((b) {
          b.map((m) {
            if (m.id == messageId) {
              m = m.rebuild(updates);
            }

            return m;
          });
        }),
      ),
    );
  }
}
