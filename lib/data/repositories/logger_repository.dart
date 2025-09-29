import 'package:logging/logging.dart';

import '../../domain/models/log_entry.dart';
import '../../domain/repositories.dart';
import '../services/local/storage/logging_storage_service.dart';

class LoggerRepositoryImpl extends LoggerRepository {
  LoggerRepositoryImpl({
    required LoggingStorageService loggingStorageService,
    required this.startingAppMessage,
    required this.maxLogCount,
  }) : _loggingStorageService = loggingStorageService;

  final LoggingStorageService _loggingStorageService;
  final String startingAppMessage;
  final int maxLogCount;
  int? _logIndex;
  AppLog? _startingRecord;

  Future<DateTime?> _getStartingRecordTime() async {
    if (_startingRecord == null) {
      _startingRecord = await _loggingStorageService.findLatestOf(
        startingAppMessage,
      );
      if (_startingRecord != null) {
        _logIndex = await _loggingStorageService.getCount(
          since: _startingRecord?.time,
        );
      }
    }
    return _startingRecord?.time;
  }

  Future<void> _truncateLogs() async {
    final startingRecordTime = await _getStartingRecordTime();
    if (startingRecordTime == null) return;

    await _loggingStorageService.deleteBefore(startingRecordTime);
    _logIndex = await _loggingStorageService.getCount();
  }

  @override
  Future<int> appendLog(LogRecord record, {Duration? offset}) async {
    final result = await _loggingStorageService.append(record, offset: offset);
    if (_logIndex != null) {
      _logIndex = _logIndex! + 1;
    } else {
      _logIndex = await _loggingStorageService.getCount();
    }

    if (_logIndex! > maxLogCount) {
      await _truncateLogs();
    }

    return result;
  }

  @override
  Future<int> getLogCount() {
    return _loggingStorageService.getCount();
  }

  @override
  Future<int> getCurrentRunLogCount() async {
    final startingRecordTime = await _getStartingRecordTime();
    if (startingRecordTime == null) return 0;

    return _loggingStorageService.getCount(since: startingRecordTime);
  }

  @override
  Future<List<LogEntry>> getLogs() async {
    final logs = await _loggingStorageService.getAll();
    return logs.map(_fromAppLog).toList();
  }

  @override
  Future<List<LogEntry>> getCurrentRunLogs() async {
    final startingRecordTime = await _getStartingRecordTime();
    if (startingRecordTime == null) return [];

    final logs = await _loggingStorageService.getAll(since: startingRecordTime);
    return logs.map(_fromAppLog).toList();
  }

  @override
  Future<int> clear() {
    return _loggingStorageService.deleteAll();
  }
}

LogEntry _fromAppLog(AppLog record) {
  return LogEntry(
    time: record.time,
    level: record.level,
    loggerName: record.loggerName,
    message: record.message,
    error: record.error,
    stackTrace: record.stackTrace,
  );
}
