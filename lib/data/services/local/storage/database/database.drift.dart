// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/data/services/local/storage/database/models/remote_action.drift.dart'
    as i1;
import 'package:frigoligo/data/services/local/storage/database/models/metadata.drift.dart'
    as i2;
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart'
    as i3;
import 'package:frigoligo/data/services/local/storage/database/models/app_log.drift.dart'
    as i4;
import 'package:frigoligo/data/services/local/storage/database/daos/app_logs.dart'
    as i5;
import 'package:frigoligo/data/services/local/storage/database/database.dart'
    as i6;
import 'package:frigoligo/data/services/local/storage/database/daos/articles.dart'
    as i7;
import 'package:frigoligo/data/services/local/storage/database/daos/metadata.dart'
    as i8;
import 'package:drift/internal/modular.dart' as i9;

abstract class $DB extends i0.GeneratedDatabase {
  $DB(i0.QueryExecutor e) : super(e);
  $DBManager get managers => $DBManager(this);
  late final i1.RemoteActions remoteActions = i1.RemoteActions(this);
  late final i2.Metadata metadata = i2.Metadata(this);
  late final i3.Articles articles = i3.Articles(this);
  late final i3.ArticleScrollPositions articleScrollPositions =
      i3.ArticleScrollPositions(this);
  late final i3.ArticlesFts articlesFts = i3.ArticlesFts(this);
  late final i4.AppLogs appLogs = i4.AppLogs(this);
  late final i5.AppLogsDao appLogsDao = i5.AppLogsDao(this as i6.DB);
  late final i7.ArticlesDao articlesDao = i7.ArticlesDao(this as i6.DB);
  late final i8.MetadataDao metadataDao = i8.MetadataDao(this as i6.DB);
  i3.ArticleDrift get articleDrift => i9.ReadDatabaseContainer(
    this,
  ).accessor<i3.ArticleDrift>(i3.ArticleDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    remoteActions,
    metadata,
    articles,
    articleScrollPositions,
    articlesFts,
    i3.articlesAi,
    i3.articlesAd,
    i3.articlesAu,
    appLogs,
  ];
  @override
  i0.StreamQueryUpdateRules get streamUpdateRules =>
      const i0.StreamQueryUpdateRules([
        i0.WritePropagation(
          on: i0.TableUpdateQuery.onTableName(
            'articles',
            limitUpdateKind: i0.UpdateKind.insert,
          ),
          result: [i0.TableUpdate('articles_fts', kind: i0.UpdateKind.insert)],
        ),
        i0.WritePropagation(
          on: i0.TableUpdateQuery.onTableName(
            'articles',
            limitUpdateKind: i0.UpdateKind.delete,
          ),
          result: [i0.TableUpdate('articles_fts', kind: i0.UpdateKind.insert)],
        ),
        i0.WritePropagation(
          on: i0.TableUpdateQuery.onTableName(
            'articles',
            limitUpdateKind: i0.UpdateKind.update,
          ),
          result: [i0.TableUpdate('articles_fts', kind: i0.UpdateKind.insert)],
        ),
      ]);
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
  i3.$ArticlesFtsTableManager get articlesFts =>
      i3.$ArticlesFtsTableManager(_db, _db.articlesFts);
  i4.$AppLogsTableManager get appLogs =>
      i4.$AppLogsTableManager(_db, _db.appLogs);
}
