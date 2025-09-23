import '../../config/logging.dart';
import '../../domain/models/log_entry.dart';
import '../../domain/repositories.dart';
import '../services/local/storage/database/models/app_log.drift.dart';
import '../services/local/storage/storage_service.dart';

class LoggerRepositoryImpl extends LoggerRepository {
  static int _logIndex = 0;

  LoggerRepositoryImpl(this._storage);

  final LocalStorageService _storage;
  AppLog? _startingRecord;

  Future<DateTime?> _getStartingRecordTime() async {
    if (_startingRecord == null) {
      _startingRecord = await _storage.latestOccurrenceOf(startingAppMessage);
      _logIndex =
          _startingRecord != null
              ? await _storage.getLogCount(since: _startingRecord?.time)
              : 0;
    }
    return _startingRecord?.time;
  }

  Future<void> _truncateLogs() async {
    final startingRecordTime = await _getStartingRecordTime();
    if (startingRecordTime == null) return;

    await _storage.removeLogsBefore(startingRecordTime);
    _logIndex = 0;
  }

  @override
  Future<int> appendLog(LogRecord record) {
    final result = _storage.appendLog(record);

    if (_logIndex >= maxLogCount) {
      _truncateLogs();
    }

    return result;
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
