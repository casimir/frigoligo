import 'package:drift/drift.dart';

import '../database.dart';
import '../models/app_log.drift.dart';
import 'app_logs.drift.dart';

@DriftAccessor(include: {'../models/app_log.drift'})
class AppLogsDao extends DatabaseAccessor<DB> with $AppLogsDaoMixin {
  AppLogsDao(super.attachedDatabase);

  Future<int> getLineCount() => appLogs.count().getSingle();

  Future<AppLog?> index(int n) {
    return (select(appLogs)
          ..orderBy([(t) => OrderingTerm.desc(t.time)])
          ..limit(1, offset: n))
        .getSingleOrNull();
  }

  Future<AppLog?> lastStartingRecord() {
    return (select(appLogs)
          ..where((t) => t.message.equals('starting app'))
          ..orderBy([(t) => OrderingTerm.desc(t.time)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> truncate() {
    return transaction(() async {
      final firstRecord = await lastStartingRecord();
      if (firstRecord == null) return 0;

      return (delete(appLogs)
        ..where((t) => t.time.isSmallerThanValue(firstRecord.time))).go();
    });
  }

  Future<void> clear() => delete(appLogs).go();

  Future<int> getCurrentRunLineCount() async {
    final firstRecord = await lastStartingRecord();
    if (firstRecord == null) return 0;

    return await appLogs
        .count(where: (t) => t.time.isBiggerOrEqualValue(firstRecord.time))
        .getSingle();
  }

  Future<List<String>> getLines(bool onlyCurrentRun) async {
    final query = selectOnly(appLogs)..addColumns([appLogs.logline]);

    if (onlyCurrentRun) {
      final firstRecord = await lastStartingRecord();
      if (firstRecord == null) return [];

      query.where(appLogs.time.isBiggerOrEqualValue(firstRecord.time));
    }

    query.orderBy([
      OrderingTerm(expression: appLogs.time, mode: OrderingMode.asc),
    ]);

    return query.map((row) => row.read(appLogs.logline)!).get();
  }
}
