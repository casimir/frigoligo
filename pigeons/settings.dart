import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/settings.g.dart',
    swiftOut: 'ios/Features/Settings/Settings.g.swift',
    dartPackageName: 'frigoligo',
    swiftOptions: SwiftOptions(includeErrorClass: false),
  ),
)
class AppSettings {
  late bool appBadge;
  late bool tagSaveEnabled;
  late String tagSaveLabel;
}

class SessionData {
  late String serverType; // "freon" | "wallabag"
  late String serverUrl;
  String? apiToken; // freon only
  String? clientId; // wallabag only
  String? clientSecret; // wallabag only
  String? accessToken; // wallabag only
  String? tokenExpiration; // wallabag only, ISO8601
  int? lastSyncTimestamp; // seconds since epoch; null = never synced
}

class NativeLogEntry {
  late String time; // ISO8601
  late String level;
  late String loggerName;
  late String message;
  String? error;
}

/// Pushes updated settings state into the native settings screen.
@HostApi()
abstract class SettingsApi {
  void updateAppSettings(AppSettings settings);
}

/// Callbacks from the native settings screen to the Dart bridge.
@FlutterApi()
abstract class SettingsFlutterApi {
  @async
  void setAppSettings(AppSettings settings);
  @async
  void clearCache();
}

/// Callbacks from the native session details screen to the Dart bridge.
@FlutterApi()
abstract class SessionDetailsFlutterApi {
  @async
  SessionData getSessionData();
  @async
  void logout();
  @async
  void refreshToken();
}

/// Callbacks from the native log console screen to the Dart bridge.
@FlutterApi()
abstract class LogConsoleFlutterApi {
  @async
  List<NativeLogEntry> getLogs(bool onlyCurrentRun);
  @async
  void clearLogs();
}
