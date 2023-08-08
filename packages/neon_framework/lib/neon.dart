import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:neon_framework/src/app.dart';
import 'package:neon_framework/src/blocs/accounts.dart';
import 'package:neon_framework/src/blocs/first_launch.dart';
import 'package:neon_framework/src/blocs/next_push.dart';
import 'package:neon_framework/src/blocs/push_notifications.dart';
import 'package:neon_framework/src/blocs/sync.dart';
import 'package:neon_framework/src/models/account.dart';
import 'package:neon_framework/src/models/app_implementation.dart';
import 'package:neon_framework/src/models/disposable.dart';
import 'package:neon_framework/src/platform/platform.dart';
import 'package:neon_framework/src/theme/neon.dart';
import 'package:neon_framework/src/utils/global_options.dart';
import 'package:neon_framework/src/utils/provider.dart';
import 'package:neon_framework/src/utils/user_agent.dart';
import 'package:neon_framework/storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

/// Runs Neon with the given [appImplementations].
///
/// Optionally provide a [theme] to set the default style.
Future<void> runNeon({
  required BuiltSet<AppImplementation> appImplementations,
  required NeonTheme theme,
  @visibleForTesting WidgetsBinding? bindingOverride,
  @visibleForTesting Account? account,
  @visibleForTesting bool firstLaunchDisabled = false,
  @visibleForTesting bool nextPushDisabled = false,
}) async {
  final binding = bindingOverride ?? WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await NeonPlatform.instance.init();
  await NeonStorage().init();

  final packageInfo = await PackageInfo.fromPlatform();
  buildUserAgent(packageInfo);

  final globalOptions = GlobalOptions(
    packageInfo,
  );

  final accountsBloc = AccountsBloc(
    globalOptions,
    appImplementations,
  );
  if (account != null) {
    accountsBloc
      ..addAccount(account)
      ..setActiveAccount(account);
  }
  PushNotificationsBloc(
    accountsBloc,
    globalOptions,
  );
  final firstLaunchBloc = FirstLaunchBloc(
    disabled: firstLaunchDisabled,
  );
  final nextPushBloc = NextPushBloc(
    accountsBloc,
    globalOptions,
    disabled: nextPushDisabled,
  );
  final syncBloc = SyncBloc(
    accountsBloc,
    appImplementations,
  );

  runApp(
    MultiProvider(
      providers: [
        NeonProvider<GlobalOptions>.value(value: globalOptions),
        NeonProvider<AccountsBloc>.value(value: accountsBloc),
        NeonProvider<FirstLaunchBloc>.value(value: firstLaunchBloc),
        NeonProvider<NextPushBloc>.value(value: nextPushBloc),
        NeonProvider<SyncBloc>.value(value: syncBloc),
        Provider<BuiltSet<AppImplementation>>(
          create: (_) => appImplementations,
          dispose: (_, appImplementations) => appImplementations.disposeAll(),
        ),
        Provider<PackageInfo>.value(value: packageInfo),
      ],
      child: NeonApp(neonTheme: theme),
    ),
  );
}
