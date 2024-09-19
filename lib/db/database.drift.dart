// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/db/models/app_log.drift.dart' as i1;
import 'package:frigoligo/db/models/article.drift.dart' as i2;
import 'package:frigoligo/db/models/metadata.drift.dart' as i3;
import 'package:frigoligo/db/models/remote_action.drift.dart' as i4;
import 'package:frigoligo/db/daos/app_logs.dart' as i5;
import 'package:frigoligo/db/database.dart' as i6;
import 'package:frigoligo/db/daos/articles.dart' as i7;
import 'package:frigoligo/db/daos/metadata.dart' as i8;

abstract class $DB extends i0.GeneratedDatabase {
  $DB(i0.QueryExecutor e) : super(e);
  $DBManager get managers => $DBManager(this);
  late final i1.$AppLogsTable appLogs = i1.$AppLogsTable(this);
  late final i2.$ArticlesTable articles = i2.$ArticlesTable(this);
  late final i2.$ArticleScrollPositionsTable articleScrollPositions =
      i2.$ArticleScrollPositionsTable(this);
  late final i3.$MetadataTable metadata = i3.$MetadataTable(this);
  late final i4.$RemoteActionsTable remoteActions =
      i4.$RemoteActionsTable(this);
  late final i5.AppLogsDao appLogsDao = i5.AppLogsDao(this as i6.DB);
  late final i7.ArticlesDao articlesDao = i7.ArticlesDao(this as i6.DB);
  late final i8.MetadataDao metadataDao = i8.MetadataDao(this as i6.DB);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities =>
      [appLogs, articles, articleScrollPositions, metadata, remoteActions];
}

class $DBManager {
  final $DB _db;
  $DBManager(this._db);
  i1.$$AppLogsTableTableManager get appLogs =>
      i1.$$AppLogsTableTableManager(_db, _db.appLogs);
  i2.$$ArticlesTableTableManager get articles =>
      i2.$$ArticlesTableTableManager(_db, _db.articles);
  i2.$$ArticleScrollPositionsTableTableManager get articleScrollPositions =>
      i2.$$ArticleScrollPositionsTableTableManager(
          _db, _db.articleScrollPositions);
  i3.$$MetadataTableTableManager get metadata =>
      i3.$$MetadataTableTableManager(_db, _db.metadata);
  i4.$$RemoteActionsTableTableManager get remoteActions =>
      i4.$$RemoteActionsTableTableManager(_db, _db.remoteActions);
}
