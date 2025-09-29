import 'package:logging/logging.dart';

import 'models/log_entry.dart';

abstract class LoggerRepository {
  Future<int> appendLog(LogRecord record, {Duration? offset});

  Future<int> getLogCount();
  Future<int> getCurrentRunLogCount();

  Future<List<LogEntry>> getLogs();
  Future<List<LogEntry>> getCurrentRunLogs();

  Future<int> clear();

  StreamSubscription<LogRecord>? _onRecordSubscription;

  void registerLogHandler(bool enableDebugLogs) {
    Logger.root.level = enableDebugLogs ? Level.FINE : Level.INFO;
    _onRecordSubscription = Logger.root.onRecord.listen(appendLog);
  }

  void unregisterLogHandler() {
    _onRecordSubscription?.cancel();
  }
}
