import 'package:drift/drift.dart';
import 'package:logging/logging.dart';

import 'connection/connection.dart';
import 'daos/articles.dart';
import 'daos/metadata.dart';
import 'database.drift.dart';

final _log = Logger('services.local.storage.database');

@DriftDatabase(
  include: {
    'models/app_log.drift',
    'models/article.drift',
    'models/metadata.drift',
    'models/remote_action.drift',
  },
  daos: [ArticlesDao, MetadataDao],
)
class DB extends $DB {
  DB() : super(openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    // The migration strategy is pretty simple: the DB is just a local cache.
    // If the schema version changes, let's just restart from a clean slate.
    onUpgrade: (m, from, to) async {
      _log.info('migrating from version $from to $to');
      if (from == to) return;

      final keepTables = [appLogs.actualTableName];
      for (final table in m.database.allTables.toList().reversed) {
        if (keepTables.contains(table.actualTableName)) continue;
        await m.deleteTable(table.actualTableName);
      }

      if (from == 6) {
        await m.deleteTable(appLogs.actualTableName);
      }

      await m.createAll();
    },
  );

  Future<void> clear({bool keepPositions = false}) {
    return transaction(() async {
      await articles.deleteAll();
      await metadata.deleteAll();
      if (!keepPositions) await articleScrollPositions.deleteAll();
      await remoteActions.deleteAll();
    });
  }
}
