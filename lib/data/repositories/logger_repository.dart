import 'package:logging/logging.dart';

import '../../domain/models/log_entry.dart';
import '../../domain/repositories.dart';
import '../services/local/storage/database/models/app_log.drift.dart';
import '../services/local/storage/storage_service.dart';

class LoggerRepositoryImpl extends LoggerRepository {
  LoggerRepositoryImpl(this._storage);
  // TODO clean up old log records

  final LocalStorageService _storage;
  AppLog? _startingRecord;

  Future<DateTime?> _getStartingRecordTime() async {
    _startingRecord ??= await _storage.lastStartingRecord();
    return _startingRecord?.time;
  }

  @override
  Future<int> appendLog(LogRecord record) {
    return _storage.appendLog(record);
  }

  @override
  Future<int> getLogCount() {
    return _storage.getLogCount();
  }

  @override
  Future<int> getCurrentRunLogCount() async {
    final startingRecordTime = await _getStartingRecordTime();
    if (startingRecordTime == null) return 0;

    return _storage.getLogCount(since: startingRecordTime);
  }

  @override
  Future<List<LogEntry>> getLogs() async {
    final logs = await _storage.getLogs();
    return logs.map(_fromAppLog).toList();
  }

  @override
  Future<List<LogEntry>> getCurrentRunLogs() async {
    final startingRecordTime = await _getStartingRecordTime();
    if (startingRecordTime == null) return [];

    final logs = await _storage.getLogs(since: startingRecordTime);
    return logs.map(_fromAppLog).toList();
  }

  @override
  Future<int> clear() {
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
