import 'package:drift/drift.dart';

import '../../../../config/logging.dart';
import 'database/database.dart';
import 'database/models/app_log.drift.dart';

class LocalStorageService {
  LocalStorageService();

  final DB _db = DB();

  @Deprecated('this getter will be deleted at some point')
  DB get db => _db;

  int get dbVersion => _db.schemaVersion;
}

extension LoggerStorageService on LocalStorageService {
  Future<int> appendLog(LogRecord record) {
    return _db.appLogsDao
        .into(_db.appLogs)
        .insert(
          AppLogsCompanion.insert(
            time: record.time,
            level: record.level.name,
            loggerName: record.loggerName,
            message: record.message,
            error: Value.absentIfNull(record.error?.toString()),
            stackTrace: Value.absentIfNull(record.stackTrace?.toString()),
            logline: formatRecord(record),
          ),
        );
  }

  Future<int> getLogCount({bool onlyCurrentRun = false}) async {
    if (onlyCurrentRun) {
      return await _getCurrentRunLogCount();
    }
    return await _db.appLogs.count().getSingle();
  }

  Future<int> _getCurrentRunLogCount() async {
    final firstRecord = await _db.appLogsDao.lastStartingRecord();
    if (firstRecord == null) return 0;

    return await _db.appLogs
        .count(where: (t) => t.time.isBiggerOrEqualValue(firstRecord.time))
        .getSingle();
  }

  Future<List<AppLog>> getLogs({bool onlyCurrentRun = false}) async {
    if (onlyCurrentRun) {
      return await _getCurrentRunLogs();
    }
    return await (_db.select(_db.appLogs)
      ..orderBy([(t) => OrderingTerm.asc(t.time)])).get();
  }

  Future<List<AppLog>> _getCurrentRunLogs() async {
    final firstRecord = await _db.appLogsDao.lastStartingRecord();
    if (firstRecord == null) return [];

    return (_db.select(_db.appLogs)
          ..where((t) => t.time.isBiggerOrEqualValue(firstRecord.time))
          ..orderBy([(t) => OrderingTerm.asc(t.time)]))
        .get();
  }

  Future<int> clearLogs() {
    return _db.delete(_db.appLogs).go();
  }
}
