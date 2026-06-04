import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/login.g.dart',
    swiftOut: 'ios/Features/Auth/Login.g.swift',
    dartPackageName: 'frigoligo',
    swiftOptions: SwiftOptions(includeErrorClass: false),
  ),
)
class ServerCheckResult {
  String? serverType; // "wallabag" | "freon" | null on error
  String? serverUrl; // resolved canonical URL
  String? version;
  late bool selfSigned;
  String?
  errorKind; // "invalidUrl" | "unknownServerType" | "unreachable" | "versionNotSupported" | "unknown" | null on success
  String? errorMessage; // detail for "unknown" only
}

/// Pre-filled credentials from a stored wallabag session for re-auth.
class LoginPrefill {
  late String server;
  late String clientId;
  late String clientSecret;
}

/// Native login screen callbacks to Dart.
@FlutterApi()
abstract class LoginFlutterApi {
  /// Returns stored wallabag server/clientId/clientSecret for re-auth prefill,
  /// or null when there is no wallabag session (first login, freon session).
  @async
  LoginPrefill? reauthPrefill();

  @async
  ServerCheckResult checkServer(String url, bool selfSigned);
  @async
  String? loginWallabag(
    String url,
    bool selfSigned,
    String clientId,
    String clientSecret,
    String username,
    String password,
  );
  @async
  String? loginFreon(String url, bool selfSigned, String token);
  @async
  void loadDemoMode();
}
