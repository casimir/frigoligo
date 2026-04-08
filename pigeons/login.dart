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

/// Native login screen callbacks to Dart.
@FlutterApi()
abstract class LoginFlutterApi {
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
