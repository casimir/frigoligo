import 'package:drift/drift.dart';
import 'package:logging/logging.dart';

import '../utils.dart';
import 'connection/connection.dart';
import 'converters/containers.dart';
import 'daos/app_logs.dart';
import 'daos/metadata.dart';
import 'models/app_log.dart';
import 'models/article.dart';
import 'models/metadata.dart';
import 'models/remote_action.dart';

part 'database.g.dart';

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
    MetadataDao,
  ],
)
class DB extends _$DB {
  DB._() : super(openConnection());

  @override
  int get schemaVersion => 1;

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
