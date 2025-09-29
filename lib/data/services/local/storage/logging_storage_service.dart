import 'package:drift/drift.dart';
import 'package:logging/logging.dart';

import 'database/database.dart';
import 'database/models/app_log.drift.dart';

export 'database/models/app_log.drift.dart' show AppLog;

class LoggingStorageService {
  LoggingStorageService({required DB db}) : _db = db;

  final DB _db;

  @override
  Future<int> append(LogRecord record, {Duration? offset}) {
    return _db.appLogs.insertOne(
      AppLogsCompanion.insert(
        time: record.time.add(offset ?? Duration.zero),
        level: record.level.name,
        loggerName: record.loggerName,
        message: record.message,
        error: Value.absentIfNull(record.error?.toString()),
        stackTrace: Value.absentIfNull(record.stackTrace?.toString()),
      ),
    );
  }

  @override
  Future<int> getCount({DateTime? since}) async {
    Expression<bool> Function(AppLogs)? where;
    if (since != null) {
      where = (t) => t.time.isBiggerOrEqualValue(since);
    }
    return await _db.appLogs.count(where: where).getSingle();
  }

  @override
  Future<List<AppLog>> getAll({DateTime? since}) async {
    final query = _db.select(_db.appLogs);

    if (since != null) {
      query.where((t) => t.time.isBiggerOrEqualValue(since));
    }

    query.orderBy([(t) => OrderingTerm.asc(t.time)]);
    return await query.get();
  }

  @override
  Future<int> deleteBefore(DateTime time) {
    return (_db.delete(_db.appLogs)
      ..where((t) => t.time.isSmallerThanValue(time))).go();
  }

  @override
  Future<int> deleteAll() {
    return _db.delete(_db.appLogs).go();
  }

  @override
  Future<AppLog?> findLatestOf(String message) {
    return (_db.select(_db.appLogs)
          ..where((t) => t.message.equals(message))
          ..orderBy([(t) => OrderingTerm.desc(t.time)])
          ..limit(1))
        .getSingleOrNull();
  }
}
