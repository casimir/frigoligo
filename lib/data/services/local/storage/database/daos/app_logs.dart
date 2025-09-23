import 'package:drift/drift.dart';

import '../database.dart';
import '../models/app_log.drift.dart';
import 'app_logs.drift.dart';

@DriftAccessor(include: {'../models/app_log.drift'})
class AppLogsDao extends DatabaseAccessor<DB> with $AppLogsDaoMixin {
  AppLogsDao(super.attachedDatabase);

  Future<AppLog?> lastStartingRecord() {
    return (select(appLogs)
          ..where((t) => t.message.equals('starting app'))
          ..orderBy([(t) => OrderingTerm.desc(t.time)])
          ..limit(1))
        .getSingleOrNull();
  }

  // TODO move into LoggerRepository
  Future<int> truncate() {
    return transaction(() async {
      final firstRecord = await lastStartingRecord();
      if (firstRecord == null) return 0;

      return (delete(appLogs)
        ..where((t) => t.time.isSmallerThanValue(firstRecord.time))).go();
    });
  }
}
