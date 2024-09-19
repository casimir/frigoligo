import 'package:drift/drift.dart';

import '../database.dart';
import '../models/app_log.dart';
import '../models/app_log.drift.dart';
import 'app_logs.drift.dart';

@DriftAccessor(tables: [AppLogs])
class AppLogsDao extends DatabaseAccessor<DB> with $AppLogsDaoMixin {
  AppLogsDao(super.db);

  Future<int> count() => appLogs.count().getSingle();

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
            ..where((t) => t.time.isSmallerThanValue(firstRecord.time)))
          .go();
    });
  }

  Future<void> clear() => delete(appLogs).go();

  Future<List<String>> currentRunLoglines() async {
    final firstRecord = await lastStartingRecord();
    if (firstRecord == null) return [];

    return (selectOnly(appLogs)
          ..addColumns([appLogs.logline])
          ..where(appLogs.time.isBiggerOrEqualValue(firstRecord.time))
          ..orderBy([
            OrderingTerm(expression: appLogs.time, mode: OrderingMode.asc),
          ]))
        .map((row) => row.read(appLogs.logline)!)
        .get();
  }
}
