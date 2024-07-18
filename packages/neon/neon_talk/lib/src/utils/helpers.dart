import 'package:nextcloud/spreed.dart' as spreed;
import 'package:nextcloud/utils.dart';
import 'package:timezone/timezone.dart' as tz;

/// `systemMessage` of chat messages that are hidden and only need to be processed internally.
/// They modify the state of other messages, but should not be displayed to the user.
// Keep this in sync with https://github.com/nextcloud/spreed/blob/ada70487a306751accb280a475b1f123a56d4e74/src/store/conversationsStore.js#L689
const _hiddenMessages = <String>{
  'reaction',
  'reaction_revoked',
  'reaction_deleted',
  'message_deleted',
  'message_edited',
  'poll_voted',
};

/// Extension for querying if a chat message is hidden.
extension ChatMessageHidden on spreed.$ChatMessageInterface {
  /// Chat message is hidden for the user and only needs to be processed internally.
  bool get isHidden => _hiddenMessages.contains(systemMessage);
}

/// Helper extension for [spreed.$BaseMessageInterface]
extension $BaseMessageInterfaceHelpers on spreed.$BaseMessageInterface {
  /// Parsed equivalent of [expirationTimestamp].
  tz.TZDateTime get parsedExpirationTimestamp => DateTimeUtils.fromSecondsSinceEpoch(tz.UTC, expirationTimestamp);
}

/// Helper extension for [spreed.$ChatMessageInterface]
extension $ChatMessageInterfaceHelpers on spreed.$ChatMessageInterface {
  /// Parsed equivalent of [timestamp].
  tz.TZDateTime get parsedTimestamp => DateTimeUtils.fromSecondsSinceEpoch(tz.UTC, timestamp);

  /// Parsed equivalent of [lastEditTimestamp].
  tz.TZDateTime? get parsedLastEditTimestamp =>
      lastEditTimestamp != null ? DateTimeUtils.fromSecondsSinceEpoch(tz.UTC, lastEditTimestamp!) : null;
}

/// Helper extension for [spreed.$ChatReminderInterface]
extension $ChatReminderInterfaceHelpers on spreed.$ChatReminderInterface {
  /// Parsed equivalent of [timestamp].
  tz.TZDateTime get parsedTimestamp => DateTimeUtils.fromSecondsSinceEpoch(tz.UTC, timestamp);
}

/// Helper extension for [spreed.$ReactionInterface]
extension $ReactionInterfaceHelpers on spreed.$ReactionInterface {
  /// Parsed equivalent of [timestamp].
  tz.TZDateTime get parsedTimestamp => DateTimeUtils.fromSecondsSinceEpoch(tz.UTC, timestamp);
}
