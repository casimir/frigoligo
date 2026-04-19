import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/system.g.dart',
    swiftOut: 'ios/Features/System/System.g.swift',
    dartPackageName: 'frigoligo',
    swiftOptions: SwiftOptions(includeErrorClass: false),
  ),
)
class LogData {
  late String level;
  late String loggerName;
  late String message;
  String? error;
}

/// System-level callbacks from the native layer to the Dart bridge.
@FlutterApi()
abstract class SystemFlutterApi {
  void log(LogData entry);
  @async
  void onAppResumed();
}
