import 'package:logging/logging.dart';

import '../../domain/models/log_entry.dart';
import '../../domain/repositories.dart';
import '../services/local/storage/database/models/app_log.drift.dart';
import '../services/local/storage/storage_service.dart';

class LoggerRepositoryImpl extends LoggerRepository {
  LoggerRepositoryImpl(this._storage);
  // TODO clean up old log records

  final LocalStorageService _storage;

  @override
  Future<int> appendLog(LogRecord record) {
    return _storage.appendLog(record);
  }

  @override
  Future<int> getLogCount() {
    return _storage.getLogCount();
  }

  @override
  Future<int> getCurrentRunLogCount() {
    return _storage.getLogCount(onlyCurrentRun: true);
  }

  @override
  Future<List<LogEntry>> getLogs() async {
    final logs = await _storage.getLogs();
    return logs.map(_fromAppLog).toList();
  }

  @override
  Future<List<LogEntry>> getCurrentRunLogs() async {
    final logs = await _storage.getLogs(onlyCurrentRun: true);
    return logs.map(_fromAppLog).toList();
  }

  @override
  Future<int> clearLogs() {
    return _storage.clearLogs();
  }
}

LogEntry _fromAppLog(AppLog record) {
  return LogEntry(
    time: record.time,
    level: record.level,
    loggerName: record.loggerName,
    message: record.message,
  );
}
