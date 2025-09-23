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

  Future<AppLog?> lastStartingRecord() {
    return (_db.select(_db.appLogs)
          ..where((t) => t.message.equals(startingAppMessage))
          ..orderBy([(t) => OrderingTerm.desc(t.time)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> getLogCount({DateTime? since}) async {
    Expression<bool> Function(AppLogs)? where;
    if (since != null) {
      where = (t) => t.time.isBiggerOrEqualValue(since);
    }
    return await _db.appLogs.count(where: where).getSingle();
  }

  Future<List<AppLog>> getLogs({DateTime? since}) async {
    final query = _db.select(_db.appLogs);

    if (since != null) {
      query.where((t) => t.time.isBiggerOrEqualValue(since));
    }

    query.orderBy([(t) => OrderingTerm.asc(t.time)]);
    return await query.get();
  }

  Future<int> removeLogsBefore(DateTime time) {
    return (_db.delete(_db.appLogs)
      ..where((t) => t.time.isSmallerThanValue(time))).go();
  }

  Future<int> clearLogs() {
    return _db.delete(_db.appLogs).go();
  }
}
