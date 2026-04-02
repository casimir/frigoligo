import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/auth_gate.g.dart',
    swiftOut: 'ios/Features/Auth/AuthGate.g.swift',
    dartPackageName: 'frigoligo',
  ),
)
/// Dart → Swift. Controls the native auth gate lifecycle.
@HostApi()
abstract class AuthGateApi {
  /// Called when no session exists; Swift must present the login FlutterVC.
  void requireLogin();

  /// Called after successful login; Swift must dismiss the login FlutterVC.
  void loginDidComplete();
}
