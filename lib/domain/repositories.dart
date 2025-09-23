import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../config/logging.dart';
import 'models/log_entry.dart';

abstract class LoggerRepository {
  Future<int> appendLog(LogRecord record);

  Future<int> getLogCount();
  Future<int> getCurrentRunLogCount();

  Future<List<LogEntry>> getLogs();
  Future<List<LogEntry>> getCurrentRunLogs();

  Future<int> clear();

  void registerLogHandler(bool enableDebugLogs) {
    Logger.root.level = enableDebugLogs ? Level.FINE : Level.INFO;
    Logger.root.onRecord.listen((record) {
      appendLog(record);
      debugPrint(formatRecord(record));
    });
  }
}
