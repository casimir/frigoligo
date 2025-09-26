import 'package:frigoligo/data/services/local/storage/logging_storage_service.dart';
import 'package:logging/src/log_record.dart';

class InMemoryLoggingStorageService implements LoggingStorageService {
  static int _id = 0;

  final List<AppLog> _logs = [];

  @override
  Future<int> append(LogRecord record) async {
    _logs.add(
      AppLog(
        id: _id++,
        time: record.time,
        level: record.level.name,
        loggerName: record.loggerName,
        message: record.message,
      ),
    );
    return 1;
  }

  @override
  Future<int> getCount({DateTime? since}) async {
    return since != null
        ? _logs.where((log) => log.time.compareTo(since) >= 0).length
        : _logs.length;
  }

  @override
  Future<List<AppLog>> getAll({DateTime? since}) async {
    return since != null
        ? _logs.where((log) => log.time.compareTo(since) >= 0).toList()
        : _logs.toList();
  }

  @override
  Future<int> deleteBefore(DateTime time) async {
    _logs.removeWhere((log) => log.time.isBefore(time));
    return 1;
  }

  @override
  Future<int> deleteAll() async {
    final count = _logs.length;
    _logs.clear();
    return count;
  }

  @override
  Future<AppLog?> findLatestOf(String message) async {
    for (final log in _logs.reversed) {
      if (log.message == message) {
        return log;
      }
    }
    return null;
  }
}
