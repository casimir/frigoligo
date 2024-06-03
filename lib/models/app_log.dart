import 'package:isar/isar.dart';
import 'package:logging/logging.dart';

part 'app_log.g.dart';

@collection
class AppLog {
  String id;
  int get isarId => Isar.fastHash(id);

  DateTime time;
  String level;
  String loggerName;
  String message;
  String? error;

  AppLog({
    required this.id,
    required this.time,
    required this.level,
    required this.loggerName,
    required this.message,
    this.error,
  });

  String get logline {
    var line = '[$time] $level $loggerName $message';
    if (error != null) {
      line += ' ($error)';
    }
    return line;
  }

  factory AppLog.fromLogRecord(LogRecord record) {
    return AppLog(
      id: record.time.toIso8601String() + record.sequenceNumber.toString(),
      time: record.time,
      level: record.level.name,
      loggerName: record.loggerName,
      message: record.message,
      error: record.error?.toString(),
    );
  }
}
