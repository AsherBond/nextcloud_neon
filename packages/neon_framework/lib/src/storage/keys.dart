import 'package:meta/meta.dart';

/// Interface of a storable element.
///
/// Usually used in enhanced enums to ensure uniqueness of the storage keys.
abstract interface class Storable {
  /// The key of this storage element.
  String get value;
}

/// Unique storage keys.
///
/// Required by the users of the `NeonStorage` storage backend.
@internal
enum StorageKeys implements Storable {
  /// The key for the `AppImplementation`s.
  apps._('app'),

  /// The key for the `Account`s and their `AccountOptions`.
  accountOptions._('accounts'),

  /// The key for the list of logged in `Account`s.
  accounts._('accounts-accounts'),

  /// The key for the `GlobalOptions`.
  global._('global'),

  /// The key for the `AccountsBloc` last used account.
  lastUsedAccount._('last-used-account'),

  /// The key used by the `PushNotificationsBloc` to persist subscriptions.
  pushSubscriptions._('push-subscriptions'),

  /// The key for the `FirstLaunchBloc`.
  firstLaunch._('first-launch'),

  /// The key for the storing the device private key used for push notification encryption.
  notificationsDevicePrivateKey._('notifications-device-private-key');

  const StorageKeys._(this.value);

  @override
  final String value;
}
