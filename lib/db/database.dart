import 'package:drift/drift.dart';
import 'package:logging/logging.dart';

import '../utils.dart';
import 'connection/connection.dart';
import 'daos/app_logs.dart';
import 'daos/articles.dart';
import 'daos/metadata.dart';
import 'database.drift.dart';
import 'models/app_log.dart';
import 'models/app_log.drift.dart';
import 'models/article.dart';
import 'models/metadata.dart';
import 'models/remote_action.dart';

@DriftDatabase(
  tables: [
    AppLogs,
    Articles,
    ArticleScrollPositions,
    Metadata,
    RemoteActions,
  ],
  daos: [
    AppLogsDao,
    ArticlesDao,
    MetadataDao,
  ],
)
class DB extends $DB {
  DB._() : super(openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // The migration strategy is pretty simple: the DB is just a local cache.
        // If the schema version changes, let's just restart from a clean slate.
        onUpgrade: (m, from, to) async {
          if (from != to) {
            final keepTables = [appLogs.actualTableName];
            for (final table in m.database.allTables.toList().reversed) {
              if (keepTables.contains(table.actualTableName)) continue;
              await m.deleteTable(table.actualTableName);
            }
            await m.createAll();
          }
        },
      );

  Future<int> appendLog(LogRecord record) {
    return into(appLogs).insert(AppLogsCompanion.insert(
      time: record.time,
      level: record.level.name,
      loggerName: record.loggerName,
      message: record.message,
      error: Value.absentIfNull(record.error?.toString()),
      stackTrace: Value.absentIfNull(record.stackTrace?.toString()),
      logline: loglineFromRecord(record),
    ));
  }

  Future<void> clear({bool keepPositions = false}) {
    return transaction(() async {
      await articles.deleteAll();
      await metadata.deleteAll();
      if (!keepPositions) await articleScrollPositions.deleteAll();
      await remoteActions.deleteAll();
    });
  }

  static DB? _instance;
  static DB get() {
    _instance ??= DB._();
    return _instance!;
  }
}
