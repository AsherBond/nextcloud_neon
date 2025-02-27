import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class TalkLocalizationsEn extends TalkLocalizations {
  TalkLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get actorSelf => 'You';

  @override
  String get actorGuest => 'Guest';

  @override
  String get roomCreate => 'Create room';

  @override
  String get roomCreateUserName => 'User name';

  @override
  String get roomCreateGroupName => 'Group name';

  @override
  String get roomCreateRoomName => 'Room name';

  @override
  String roomType(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'oneToOne': 'Private',
        'group': 'Group',
        'public': 'Public',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get roomWriteMessage => 'Write a message...';

  @override
  String get roomMessageAddEmoji => 'Add emoji to message';

  @override
  String get roomMessageSend => 'Send message';

  @override
  String get roomMessageReply => 'Reply';

  @override
  String get roomMessageReaction => 'Add reaction';

  @override
  String get roomMessageDelete => 'Delete';

  @override
  String get roomMessageEdit => 'Edit';

  @override
  String get roomMessageEdited => 'edited';

  @override
  String roomMessageLastEdited(String name, String time) {
    return 'Last edited by $name at $time';
  }

  @override
  String get reactions => 'Reactions';

  @override
  String get reactionsAll => 'All';

  @override
  String get reactionsSeeAll => 'See all reactions';

  @override
  String get reactionsAddNew => 'Add a new reaction';

  @override
  String get reactionsLoading => 'Loading reactions';

  @override
  String get roomsCreateNew => 'Create new room';
}
