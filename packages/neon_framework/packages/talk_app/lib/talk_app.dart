/// The Neon client for the Talk app.
///
/// Add `TalkApp()` to your runNeon command to execute this app.
library;

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:neon_framework/models.dart';
import 'package:nextcloud/core.dart' as core;
import 'package:nextcloud/nextcloud.dart';
import 'package:nextcloud/spreed.dart' as spreed;
import 'package:rxdart/rxdart.dart';
import 'package:talk_app/l10n/localizations.dart';
import 'package:talk_app/src/blocs/talk.dart';
import 'package:talk_app/src/options.dart';
import 'package:talk_app/src/pages/main.dart';
import 'package:talk_app/src/routes.dart';
import 'package:talk_app/src/theme.dart';

/// Implementation of the server `talk` app.
@experimental
class TalkApp extends AppImplementation<TalkBloc, TalkOptions> {
  /// Creates a new Talk app implementation instance.
  TalkApp();

  @override
  final String id = 'talk';

  @override
  final BuiltSet<String> additionalMatchingIDs = BuiltSet([spreed.appID]);

  @override
  final LocalizationsDelegate<TalkLocalizations> localizationsDelegate = TalkLocalizations.delegate;

  @override
  final List<Locale> supportedLocales = TalkLocalizations.supportedLocales;

  @override
  late final TalkOptions options = TalkOptions(storage);

  @override
  TalkBloc buildBloc(Account account) => TalkBloc(
        account: account,
      );

  @override
  final Widget page = const TalkMainPage();

  @override
  final RouteBase route = $talkAppRoute;

  @override
  final theme = const TalkTheme();

  @override
  BehaviorSubject<int> getUnreadCounter(TalkBloc bloc) => bloc.unreadCounter;

  @override
  VersionCheck getVersionCheck(
    Account account,
    core.OcsGetCapabilitiesResponseApplicationJson_Ocs_Data capabilities,
  ) =>
      account.client.spreed.getVersionCheck(capabilities);
}
