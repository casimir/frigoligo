import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/auth_gate.g.dart',
    swiftOut: 'ios/Features/Auth/AuthGate.g.swift',
    dartPackageName: 'frigoligo',
  ),
)
/// Controls the native auth gate lifecycle.
@HostApi()
abstract class AuthGateApi {
  /// Called when no session exists.
  void requireLogin();

  /// Called after successful login.
  void loginDidComplete();

  /// Called when a session exists but the token has expired.
  void reauthRequired();
}
