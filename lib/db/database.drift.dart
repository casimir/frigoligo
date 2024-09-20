// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/db/models/remote_action.drift.dart' as i1;
import 'package:frigoligo/db/models/metadata.drift.dart' as i2;
import 'package:frigoligo/db/models/article.drift.dart' as i3;
import 'package:frigoligo/db/models/app_log.drift.dart' as i4;
import 'package:frigoligo/db/daos/app_logs.dart' as i5;
import 'package:frigoligo/db/database.dart' as i6;
import 'package:frigoligo/db/daos/articles.dart' as i7;
import 'package:frigoligo/db/daos/metadata.dart' as i8;

abstract class $DB extends i0.GeneratedDatabase {
  $DB(i0.QueryExecutor e) : super(e);
  $DBManager get managers => $DBManager(this);
  late final i1.RemoteActions remoteActions = i1.RemoteActions(this);
  late final i2.Metadata metadata = i2.Metadata(this);
  late final i3.Articles articles = i3.Articles(this);
  late final i3.ArticleScrollPositions articleScrollPositions =
      i3.ArticleScrollPositions(this);
  late final i4.AppLogs appLogs = i4.AppLogs(this);
  late final i5.AppLogsDao appLogsDao = i5.AppLogsDao(this as i6.DB);
  late final i7.ArticlesDao articlesDao = i7.ArticlesDao(this as i6.DB);
  late final i8.MetadataDao metadataDao = i8.MetadataDao(this as i6.DB);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities =>
      [remoteActions, metadata, articles, articleScrollPositions, appLogs];
}

class $DBManager {
  final $DB _db;
  $DBManager(this._db);
  i1.$RemoteActionsTableManager get remoteActions =>
      i1.$RemoteActionsTableManager(_db, _db.remoteActions);
  i2.$MetadataTableManager get metadata =>
      i2.$MetadataTableManager(_db, _db.metadata);
  i3.$ArticlesTableManager get articles =>
      i3.$ArticlesTableManager(_db, _db.articles);
  i3.$ArticleScrollPositionsTableManager get articleScrollPositions =>
      i3.$ArticleScrollPositionsTableManager(_db, _db.articleScrollPositions);
  i4.$AppLogsTableManager get appLogs =>
      i4.$AppLogsTableManager(_db, _db.appLogs);
}
