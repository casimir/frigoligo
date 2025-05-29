import 'package:drift/drift.dart';
import 'package:logging/logging.dart';

import '../utils.dart';
import 'connection/connection.dart';
import 'daos/app_logs.dart';
import 'daos/articles.dart';
import 'daos/metadata.dart';
import 'database.drift.dart';
import 'models/app_log.drift.dart';

@DriftDatabase(
  include: {
    'models/app_log.drift',
    'models/article.drift',
    'models/metadata.drift',
    'models/remote_action.drift',
  },
  daos: [
    AppLogsDao,
    ArticlesDao,
    MetadataDao,
  ],
)
class DB extends $DB {
  static final DB _instance = DB._();

  DB._() : super(openConnection());

  factory DB() => _instance;

  @override
  int get schemaVersion => 6;

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
}
