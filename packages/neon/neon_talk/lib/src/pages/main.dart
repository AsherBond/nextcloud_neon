import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neon_framework/blocs.dart';
import 'package:neon_framework/utils.dart';
import 'package:neon_framework/widgets.dart';
import 'package:neon_talk/src/blocs/talk.dart';
import 'package:neon_talk/src/widgets/message.dart';
import 'package:neon_talk/src/widgets/room_avatar.dart';
import 'package:neon_talk/src/widgets/unread_indicator.dart';
import 'package:nextcloud/spreed.dart' as spreed;

/// The main page displaying the chat list.
class TalkMainPage extends StatefulWidget {
  /// Creates a new Talk main page.
  const TalkMainPage({super.key});

  @override
  State<TalkMainPage> createState() => _TalkMainPageState();
}

class _TalkMainPageState extends State<TalkMainPage> {
  late TalkBloc bloc;
  late StreamSubscription<Object> errorsSubscription;

  @override
  void initState() {
    super.initState();

    bloc = NeonProvider.of<TalkBloc>(context);
    errorsSubscription = bloc.errors.listen((error) {
      NeonError.showSnackbar(context, error);
    });
  }

  @override
  void dispose() {
    unawaited(errorsSubscription.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ResultListBuilder(
        scrollKey: 'talk-rooms',
        subject: bloc.rooms,
        onRefresh: bloc.refresh,
        builder: (context, rooms) => SliverList.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) => buildRoom(rooms[index]),
        ),
      );

  Widget buildRoom(spreed.Room room) {
    Widget? subtitle;
    Widget? trailing;

    final lastChatMessage = room.lastMessage.chatMessage;
    if (lastChatMessage != null) {
      subtitle = TalkMessagePreview(
        actorId: room.actorId,
        roomType: spreed.RoomType.fromValue(room.type),
        chatMessage: lastChatMessage,
      );
    }

    if (room.unreadMessages > 0) {
      trailing = TalkUnreadIndicator(
        room: room,
      );
    }

    return ListTile(
      leading: TalkRoomAvatar(
        room: room,
      ),
      title: Text(room.displayName),
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
