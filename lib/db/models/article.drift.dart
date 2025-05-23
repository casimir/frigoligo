// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/db/models/article.drift.dart' as i1;
import 'package:frigoligo/db/converters/containers.dart' as i2;
import 'package:drift/internal/modular.dart' as i3;

typedef $ArticlesCreateCompanionBuilder =
    i1.ArticlesCompanion Function({
      i0.Value<int> id,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String title,
      i0.Value<String?> domainName,
      required String url,
      i0.Value<String?> content,
      i0.Value<String?> language,
      required int readingTime,
      i0.Value<String?> previewPicture,
      i0.Value<DateTime?> archivedAt,
      i0.Value<DateTime?> starredAt,
      required List<String> tags,
    });
typedef $ArticlesUpdateCompanionBuilder =
    i1.ArticlesCompanion Function({
      i0.Value<int> id,
      i0.Value<DateTime> createdAt,
      i0.Value<DateTime> updatedAt,
      i0.Value<String> title,
      i0.Value<String?> domainName,
      i0.Value<String> url,
      i0.Value<String?> content,
      i0.Value<String?> language,
      i0.Value<int> readingTime,
      i0.Value<String?> previewPicture,
      i0.Value<DateTime?> archivedAt,
      i0.Value<DateTime?> starredAt,
      i0.Value<List<String>> tags,
    });

class $ArticlesFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Articles> {
  $ArticlesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get domainName => $composableBuilder(
    column: $table.domainName,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get readingTime => $composableBuilder(
    column: $table.readingTime,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get previewPicture => $composableBuilder(
    column: $table.previewPicture,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get starredAt => $composableBuilder(
    column: $table.starredAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => i0.ColumnWithTypeConverterFilters(column),
  );
}

class $ArticlesOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Articles> {
  $ArticlesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get domainName => $composableBuilder(
    column: $table.domainName,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get readingTime => $composableBuilder(
    column: $table.readingTime,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get previewPicture => $composableBuilder(
    column: $table.previewPicture,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get starredAt => $composableBuilder(
    column: $table.starredAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ArticlesAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Articles> {
  $ArticlesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  i0.GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  i0.GeneratedColumn<String> get domainName => $composableBuilder(
    column: $table.domainName,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  i0.GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  i0.GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  i0.GeneratedColumn<int> get readingTime => $composableBuilder(
    column: $table.readingTime,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get previewPicture => $composableBuilder(
    column: $table.previewPicture,
    builder: (column) => column,
  );

  i0.GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  i0.GeneratedColumn<DateTime> get starredAt =>
      $composableBuilder(column: $table.starredAt, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<List<String>, String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);
}

class $ArticlesTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.Articles,
          i1.Article,
          i1.$ArticlesFilterComposer,
          i1.$ArticlesOrderingComposer,
          i1.$ArticlesAnnotationComposer,
          $ArticlesCreateCompanionBuilder,
          $ArticlesUpdateCompanionBuilder,
          (
            i1.Article,
            i0.BaseReferences<i0.GeneratedDatabase, i1.Articles, i1.Article>,
          ),
          i1.Article,
          i0.PrefetchHooks Function()
        > {
  $ArticlesTableManager(i0.GeneratedDatabase db, i1.Articles table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => i1.$ArticlesFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => i1.$ArticlesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => i1.$ArticlesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
                i0.Value<DateTime> updatedAt = const i0.Value.absent(),
                i0.Value<String> title = const i0.Value.absent(),
                i0.Value<String?> domainName = const i0.Value.absent(),
                i0.Value<String> url = const i0.Value.absent(),
                i0.Value<String?> content = const i0.Value.absent(),
                i0.Value<String?> language = const i0.Value.absent(),
                i0.Value<int> readingTime = const i0.Value.absent(),
                i0.Value<String?> previewPicture = const i0.Value.absent(),
                i0.Value<DateTime?> archivedAt = const i0.Value.absent(),
                i0.Value<DateTime?> starredAt = const i0.Value.absent(),
                i0.Value<List<String>> tags = const i0.Value.absent(),
              }) => i1.ArticlesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                title: title,
                domainName: domainName,
                url: url,
                content: content,
                language: language,
                readingTime: readingTime,
                previewPicture: previewPicture,
                archivedAt: archivedAt,
                starredAt: starredAt,
                tags: tags,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String title,
                i0.Value<String?> domainName = const i0.Value.absent(),
                required String url,
                i0.Value<String?> content = const i0.Value.absent(),
                i0.Value<String?> language = const i0.Value.absent(),
                required int readingTime,
                i0.Value<String?> previewPicture = const i0.Value.absent(),
                i0.Value<DateTime?> archivedAt = const i0.Value.absent(),
                i0.Value<DateTime?> starredAt = const i0.Value.absent(),
                required List<String> tags,
              }) => i1.ArticlesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                title: title,
                domainName: domainName,
                url: url,
                content: content,
                language: language,
                readingTime: readingTime,
                previewPicture: previewPicture,
                archivedAt: archivedAt,
                starredAt: starredAt,
                tags: tags,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          i0.BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ArticlesProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.Articles,
      i1.Article,
      i1.$ArticlesFilterComposer,
      i1.$ArticlesOrderingComposer,
      i1.$ArticlesAnnotationComposer,
      $ArticlesCreateCompanionBuilder,
      $ArticlesUpdateCompanionBuilder,
      (
        i1.Article,
        i0.BaseReferences<i0.GeneratedDatabase, i1.Articles, i1.Article>,
      ),
      i1.Article,
      i0.PrefetchHooks Function()
    >;
typedef $ArticleScrollPositionsCreateCompanionBuilder =
    i1.ArticleScrollPositionsCompanion Function({
      i0.Value<int> id,
      required int readingTime,
      required double progress,
    });
typedef $ArticleScrollPositionsUpdateCompanionBuilder =
    i1.ArticleScrollPositionsCompanion Function({
      i0.Value<int> id,
      i0.Value<int> readingTime,
      i0.Value<double> progress,
    });

class $ArticleScrollPositionsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ArticleScrollPositions> {
  $ArticleScrollPositionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get readingTime => $composableBuilder(
    column: $table.readingTime,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ArticleScrollPositionsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ArticleScrollPositions> {
  $ArticleScrollPositionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get readingTime => $composableBuilder(
    column: $table.readingTime,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ArticleScrollPositionsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ArticleScrollPositions> {
  $ArticleScrollPositionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<int> get readingTime => $composableBuilder(
    column: $table.readingTime,
    builder: (column) => column,
  );

  i0.GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);
}

class $ArticleScrollPositionsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ArticleScrollPositions,
          i1.ArticleScrollPosition,
          i1.$ArticleScrollPositionsFilterComposer,
          i1.$ArticleScrollPositionsOrderingComposer,
          i1.$ArticleScrollPositionsAnnotationComposer,
          $ArticleScrollPositionsCreateCompanionBuilder,
          $ArticleScrollPositionsUpdateCompanionBuilder,
          (
            i1.ArticleScrollPosition,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ArticleScrollPositions,
              i1.ArticleScrollPosition
            >,
          ),
          i1.ArticleScrollPosition,
          i0.PrefetchHooks Function()
        > {
  $ArticleScrollPositionsTableManager(
    i0.GeneratedDatabase db,
    i1.ArticleScrollPositions table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => i1.$ArticleScrollPositionsFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => i1.$ArticleScrollPositionsOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => i1.$ArticleScrollPositionsAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<int> readingTime = const i0.Value.absent(),
                i0.Value<double> progress = const i0.Value.absent(),
              }) => i1.ArticleScrollPositionsCompanion(
                id: id,
                readingTime: readingTime,
                progress: progress,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required int readingTime,
                required double progress,
              }) => i1.ArticleScrollPositionsCompanion.insert(
                id: id,
                readingTime: readingTime,
                progress: progress,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          i0.BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ArticleScrollPositionsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ArticleScrollPositions,
      i1.ArticleScrollPosition,
      i1.$ArticleScrollPositionsFilterComposer,
      i1.$ArticleScrollPositionsOrderingComposer,
      i1.$ArticleScrollPositionsAnnotationComposer,
      $ArticleScrollPositionsCreateCompanionBuilder,
      $ArticleScrollPositionsUpdateCompanionBuilder,
      (
        i1.ArticleScrollPosition,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.ArticleScrollPositions,
          i1.ArticleScrollPosition
        >,
      ),
      i1.ArticleScrollPosition,
      i0.PrefetchHooks Function()
    >;
typedef $ArticlesFtsCreateCompanionBuilder =
    i1.ArticlesFtsCompanion Function({
      required String title,
      required String content,
      i0.Value<int> rowid,
    });
typedef $ArticlesFtsUpdateCompanionBuilder =
    i1.ArticlesFtsCompanion Function({
      i0.Value<String> title,
      i0.Value<String> content,
      i0.Value<int> rowid,
    });

class $ArticlesFtsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ArticlesFts> {
  $ArticlesFtsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ArticlesFtsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ArticlesFts> {
  $ArticlesFtsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ArticlesFtsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ArticlesFts> {
  $ArticlesFtsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  i0.GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $ArticlesFtsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ArticlesFts,
          i1.ArticlesFt,
          i1.$ArticlesFtsFilterComposer,
          i1.$ArticlesFtsOrderingComposer,
          i1.$ArticlesFtsAnnotationComposer,
          $ArticlesFtsCreateCompanionBuilder,
          $ArticlesFtsUpdateCompanionBuilder,
          (
            i1.ArticlesFt,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ArticlesFts,
              i1.ArticlesFt
            >,
          ),
          i1.ArticlesFt,
          i0.PrefetchHooks Function()
        > {
  $ArticlesFtsTableManager(i0.GeneratedDatabase db, i1.ArticlesFts table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => i1.$ArticlesFtsFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => i1.$ArticlesFtsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => i1.$ArticlesFtsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> title = const i0.Value.absent(),
                i0.Value<String> content = const i0.Value.absent(),
                i0.Value<int> rowid = const i0.Value.absent(),
              }) => i1.ArticlesFtsCompanion(
                title: title,
                content: content,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String title,
                required String content,
                i0.Value<int> rowid = const i0.Value.absent(),
              }) => i1.ArticlesFtsCompanion.insert(
                title: title,
                content: content,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          i0.BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ArticlesFtsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ArticlesFts,
      i1.ArticlesFt,
      i1.$ArticlesFtsFilterComposer,
      i1.$ArticlesFtsOrderingComposer,
      i1.$ArticlesFtsAnnotationComposer,
      $ArticlesFtsCreateCompanionBuilder,
      $ArticlesFtsUpdateCompanionBuilder,
      (
        i1.ArticlesFt,
        i0.BaseReferences<i0.GeneratedDatabase, i1.ArticlesFts, i1.ArticlesFt>,
      ),
      i1.ArticlesFt,
      i0.PrefetchHooks Function()
    >;

class Articles extends i0.Table with i0.TableInfo<Articles, i1.Article> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Articles(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY',
  );
  static const i0.VerificationMeta _createdAtMeta = const i0.VerificationMeta(
    'createdAt',
  );
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>(
        'created_at',
        aliasedName,
        false,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const i0.VerificationMeta _updatedAtMeta = const i0.VerificationMeta(
    'updatedAt',
  );
  late final i0.GeneratedColumn<DateTime> updatedAt =
      i0.GeneratedColumn<DateTime>(
        'updated_at',
        aliasedName,
        false,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const i0.VerificationMeta _titleMeta = const i0.VerificationMeta(
    'title',
  );
  late final i0.GeneratedColumn<String> title = i0.GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _domainNameMeta = const i0.VerificationMeta(
    'domainName',
  );
  late final i0.GeneratedColumn<String> domainName = i0.GeneratedColumn<String>(
    'domain_name',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _urlMeta = const i0.VerificationMeta('url');
  late final i0.GeneratedColumn<String> url = i0.GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _contentMeta = const i0.VerificationMeta(
    'content',
  );
  late final i0.GeneratedColumn<String> content = i0.GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _languageMeta = const i0.VerificationMeta(
    'language',
  );
  late final i0.GeneratedColumn<String> language = i0.GeneratedColumn<String>(
    'language',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _readingTimeMeta = const i0.VerificationMeta(
    'readingTime',
  );
  late final i0.GeneratedColumn<int> readingTime = i0.GeneratedColumn<int>(
    'reading_time',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _previewPictureMeta =
      const i0.VerificationMeta('previewPicture');
  late final i0.GeneratedColumn<String> previewPicture =
      i0.GeneratedColumn<String>(
        'preview_picture',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  static const i0.VerificationMeta _archivedAtMeta = const i0.VerificationMeta(
    'archivedAt',
  );
  late final i0.GeneratedColumn<DateTime> archivedAt =
      i0.GeneratedColumn<DateTime>(
        'archived_at',
        aliasedName,
        true,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  static const i0.VerificationMeta _starredAtMeta = const i0.VerificationMeta(
    'starredAt',
  );
  late final i0.GeneratedColumn<DateTime> starredAt =
      i0.GeneratedColumn<DateTime>(
        'starred_at',
        aliasedName,
        true,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  late final i0.GeneratedColumnWithTypeConverter<List<String>, String> tags =
      i0.GeneratedColumn<String>(
        'tags',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<List<String>>(i1.Articles.$convertertags);
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    title,
    domainName,
    url,
    content,
    language,
    readingTime,
    previewPicture,
    archivedAt,
    starredAt,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.Article> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('domain_name')) {
      context.handle(
        _domainNameMeta,
        domainName.isAcceptableOrUnknown(data['domain_name']!, _domainNameMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('reading_time')) {
      context.handle(
        _readingTimeMeta,
        readingTime.isAcceptableOrUnknown(
          data['reading_time']!,
          _readingTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_readingTimeMeta);
    }
    if (data.containsKey('preview_picture')) {
      context.handle(
        _previewPictureMeta,
        previewPicture.isAcceptableOrUnknown(
          data['preview_picture']!,
          _previewPictureMeta,
        ),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('starred_at')) {
      context.handle(
        _starredAtMeta,
        starredAt.isAcceptableOrUnknown(data['starred_at']!, _starredAtMeta),
      );
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Article(
      id:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      domainName: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}domain_name'],
      ),
      url:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}url'],
          )!,
      content: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      language: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}language'],
      ),
      readingTime:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.int,
            data['${effectivePrefix}reading_time'],
          )!,
      previewPicture: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}preview_picture'],
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      starredAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}starred_at'],
      ),
      tags: i1.Articles.$convertertags.fromSql(
        attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}tags'],
        )!,
      ),
    );
  }

  @override
  Articles createAlias(String alias) {
    return Articles(attachedDatabase, alias);
  }

  static i0.TypeConverter<List<String>, String> $convertertags =
      const i2.StringListConverter();
  @override
  bool get dontWriteConstraints => true;
}

class Article extends i0.DataClass implements i0.Insertable<i1.Article> {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String? domainName;
  final String url;
  final String? content;
  final String? language;
  final int readingTime;
  final String? previewPicture;
  final DateTime? archivedAt;
  final DateTime? starredAt;
  final List<String> tags;
  const Article({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    this.domainName,
    required this.url,
    this.content,
    this.language,
    required this.readingTime,
    this.previewPicture,
    this.archivedAt,
    this.starredAt,
    required this.tags,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    map['updated_at'] = i0.Variable<DateTime>(updatedAt);
    map['title'] = i0.Variable<String>(title);
    if (!nullToAbsent || domainName != null) {
      map['domain_name'] = i0.Variable<String>(domainName);
    }
    map['url'] = i0.Variable<String>(url);
    if (!nullToAbsent || content != null) {
      map['content'] = i0.Variable<String>(content);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = i0.Variable<String>(language);
    }
    map['reading_time'] = i0.Variable<int>(readingTime);
    if (!nullToAbsent || previewPicture != null) {
      map['preview_picture'] = i0.Variable<String>(previewPicture);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = i0.Variable<DateTime>(archivedAt);
    }
    if (!nullToAbsent || starredAt != null) {
      map['starred_at'] = i0.Variable<DateTime>(starredAt);
    }
    {
      map['tags'] = i0.Variable<String>(i1.Articles.$convertertags.toSql(tags));
    }
    return map;
  }

  i1.ArticlesCompanion toCompanion(bool nullToAbsent) {
    return i1.ArticlesCompanion(
      id: i0.Value(id),
      createdAt: i0.Value(createdAt),
      updatedAt: i0.Value(updatedAt),
      title: i0.Value(title),
      domainName:
          domainName == null && nullToAbsent
              ? const i0.Value.absent()
              : i0.Value(domainName),
      url: i0.Value(url),
      content:
          content == null && nullToAbsent
              ? const i0.Value.absent()
              : i0.Value(content),
      language:
          language == null && nullToAbsent
              ? const i0.Value.absent()
              : i0.Value(language),
      readingTime: i0.Value(readingTime),
      previewPicture:
          previewPicture == null && nullToAbsent
              ? const i0.Value.absent()
              : i0.Value(previewPicture),
      archivedAt:
          archivedAt == null && nullToAbsent
              ? const i0.Value.absent()
              : i0.Value(archivedAt),
      starredAt:
          starredAt == null && nullToAbsent
              ? const i0.Value.absent()
              : i0.Value(starredAt),
      tags: i0.Value(tags),
    );
  }

  factory Article.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      title: serializer.fromJson<String>(json['title']),
      domainName: serializer.fromJson<String?>(json['domain_name']),
      url: serializer.fromJson<String>(json['url']),
      content: serializer.fromJson<String?>(json['content']),
      language: serializer.fromJson<String?>(json['language']),
      readingTime: serializer.fromJson<int>(json['reading_time']),
      previewPicture: serializer.fromJson<String?>(json['preview_picture']),
      archivedAt: serializer.fromJson<DateTime?>(json['archived_at']),
      starredAt: serializer.fromJson<DateTime?>(json['starred_at']),
      tags: serializer.fromJson<List<String>>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'title': serializer.toJson<String>(title),
      'domain_name': serializer.toJson<String?>(domainName),
      'url': serializer.toJson<String>(url),
      'content': serializer.toJson<String?>(content),
      'language': serializer.toJson<String?>(language),
      'reading_time': serializer.toJson<int>(readingTime),
      'preview_picture': serializer.toJson<String?>(previewPicture),
      'archived_at': serializer.toJson<DateTime?>(archivedAt),
      'starred_at': serializer.toJson<DateTime?>(starredAt),
      'tags': serializer.toJson<List<String>>(tags),
    };
  }

  i1.Article copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    i0.Value<String?> domainName = const i0.Value.absent(),
    String? url,
    i0.Value<String?> content = const i0.Value.absent(),
    i0.Value<String?> language = const i0.Value.absent(),
    int? readingTime,
    i0.Value<String?> previewPicture = const i0.Value.absent(),
    i0.Value<DateTime?> archivedAt = const i0.Value.absent(),
    i0.Value<DateTime?> starredAt = const i0.Value.absent(),
    List<String>? tags,
  }) => i1.Article(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    title: title ?? this.title,
    domainName: domainName.present ? domainName.value : this.domainName,
    url: url ?? this.url,
    content: content.present ? content.value : this.content,
    language: language.present ? language.value : this.language,
    readingTime: readingTime ?? this.readingTime,
    previewPicture:
        previewPicture.present ? previewPicture.value : this.previewPicture,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    starredAt: starredAt.present ? starredAt.value : this.starredAt,
    tags: tags ?? this.tags,
  );
  Article copyWithCompanion(i1.ArticlesCompanion data) {
    return Article(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      title: data.title.present ? data.title.value : this.title,
      domainName:
          data.domainName.present ? data.domainName.value : this.domainName,
      url: data.url.present ? data.url.value : this.url,
      content: data.content.present ? data.content.value : this.content,
      language: data.language.present ? data.language.value : this.language,
      readingTime:
          data.readingTime.present ? data.readingTime.value : this.readingTime,
      previewPicture:
          data.previewPicture.present
              ? data.previewPicture.value
              : this.previewPicture,
      archivedAt:
          data.archivedAt.present ? data.archivedAt.value : this.archivedAt,
      starredAt: data.starredAt.present ? data.starredAt.value : this.starredAt,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('domainName: $domainName, ')
          ..write('url: $url, ')
          ..write('content: $content, ')
          ..write('language: $language, ')
          ..write('readingTime: $readingTime, ')
          ..write('previewPicture: $previewPicture, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('starredAt: $starredAt, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    title,
    domainName,
    url,
    content,
    language,
    readingTime,
    previewPicture,
    archivedAt,
    starredAt,
    tags,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Article &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.title == this.title &&
          other.domainName == this.domainName &&
          other.url == this.url &&
          other.content == this.content &&
          other.language == this.language &&
          other.readingTime == this.readingTime &&
          other.previewPicture == this.previewPicture &&
          other.archivedAt == this.archivedAt &&
          other.starredAt == this.starredAt &&
          other.tags == this.tags);
}

class ArticlesCompanion extends i0.UpdateCompanion<i1.Article> {
  final i0.Value<int> id;
  final i0.Value<DateTime> createdAt;
  final i0.Value<DateTime> updatedAt;
  final i0.Value<String> title;
  final i0.Value<String?> domainName;
  final i0.Value<String> url;
  final i0.Value<String?> content;
  final i0.Value<String?> language;
  final i0.Value<int> readingTime;
  final i0.Value<String?> previewPicture;
  final i0.Value<DateTime?> archivedAt;
  final i0.Value<DateTime?> starredAt;
  final i0.Value<List<String>> tags;
  const ArticlesCompanion({
    this.id = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.updatedAt = const i0.Value.absent(),
    this.title = const i0.Value.absent(),
    this.domainName = const i0.Value.absent(),
    this.url = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
    this.language = const i0.Value.absent(),
    this.readingTime = const i0.Value.absent(),
    this.previewPicture = const i0.Value.absent(),
    this.archivedAt = const i0.Value.absent(),
    this.starredAt = const i0.Value.absent(),
    this.tags = const i0.Value.absent(),
  });
  ArticlesCompanion.insert({
    this.id = const i0.Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String title,
    this.domainName = const i0.Value.absent(),
    required String url,
    this.content = const i0.Value.absent(),
    this.language = const i0.Value.absent(),
    required int readingTime,
    this.previewPicture = const i0.Value.absent(),
    this.archivedAt = const i0.Value.absent(),
    this.starredAt = const i0.Value.absent(),
    required List<String> tags,
  }) : createdAt = i0.Value(createdAt),
       updatedAt = i0.Value(updatedAt),
       title = i0.Value(title),
       url = i0.Value(url),
       readingTime = i0.Value(readingTime),
       tags = i0.Value(tags);
  static i0.Insertable<i1.Article> custom({
    i0.Expression<int>? id,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<DateTime>? updatedAt,
    i0.Expression<String>? title,
    i0.Expression<String>? domainName,
    i0.Expression<String>? url,
    i0.Expression<String>? content,
    i0.Expression<String>? language,
    i0.Expression<int>? readingTime,
    i0.Expression<String>? previewPicture,
    i0.Expression<DateTime>? archivedAt,
    i0.Expression<DateTime>? starredAt,
    i0.Expression<String>? tags,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (domainName != null) 'domain_name': domainName,
      if (url != null) 'url': url,
      if (content != null) 'content': content,
      if (language != null) 'language': language,
      if (readingTime != null) 'reading_time': readingTime,
      if (previewPicture != null) 'preview_picture': previewPicture,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (starredAt != null) 'starred_at': starredAt,
      if (tags != null) 'tags': tags,
    });
  }

  i1.ArticlesCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<DateTime>? createdAt,
    i0.Value<DateTime>? updatedAt,
    i0.Value<String>? title,
    i0.Value<String?>? domainName,
    i0.Value<String>? url,
    i0.Value<String?>? content,
    i0.Value<String?>? language,
    i0.Value<int>? readingTime,
    i0.Value<String?>? previewPicture,
    i0.Value<DateTime?>? archivedAt,
    i0.Value<DateTime?>? starredAt,
    i0.Value<List<String>>? tags,
  }) {
    return i1.ArticlesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      domainName: domainName ?? this.domainName,
      url: url ?? this.url,
      content: content ?? this.content,
      language: language ?? this.language,
      readingTime: readingTime ?? this.readingTime,
      previewPicture: previewPicture ?? this.previewPicture,
      archivedAt: archivedAt ?? this.archivedAt,
      starredAt: starredAt ?? this.starredAt,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = i0.Variable<DateTime>(updatedAt.value);
    }
    if (title.present) {
      map['title'] = i0.Variable<String>(title.value);
    }
    if (domainName.present) {
      map['domain_name'] = i0.Variable<String>(domainName.value);
    }
    if (url.present) {
      map['url'] = i0.Variable<String>(url.value);
    }
    if (content.present) {
      map['content'] = i0.Variable<String>(content.value);
    }
    if (language.present) {
      map['language'] = i0.Variable<String>(language.value);
    }
    if (readingTime.present) {
      map['reading_time'] = i0.Variable<int>(readingTime.value);
    }
    if (previewPicture.present) {
      map['preview_picture'] = i0.Variable<String>(previewPicture.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = i0.Variable<DateTime>(archivedAt.value);
    }
    if (starredAt.present) {
      map['starred_at'] = i0.Variable<DateTime>(starredAt.value);
    }
    if (tags.present) {
      map['tags'] = i0.Variable<String>(
        i1.Articles.$convertertags.toSql(tags.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('domainName: $domainName, ')
          ..write('url: $url, ')
          ..write('content: $content, ')
          ..write('language: $language, ')
          ..write('readingTime: $readingTime, ')
          ..write('previewPicture: $previewPicture, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('starredAt: $starredAt, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class ArticleScrollPositions extends i0.Table
    with i0.TableInfo<ArticleScrollPositions, i1.ArticleScrollPosition> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ArticleScrollPositions(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY',
  );
  static const i0.VerificationMeta _readingTimeMeta = const i0.VerificationMeta(
    'readingTime',
  );
  late final i0.GeneratedColumn<int> readingTime = i0.GeneratedColumn<int>(
    'reading_time',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _progressMeta = const i0.VerificationMeta(
    'progress',
  );
  late final i0.GeneratedColumn<double> progress = i0.GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: i0.DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [id, readingTime, progress];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'article_scroll_positions';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ArticleScrollPosition> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reading_time')) {
      context.handle(
        _readingTimeMeta,
        readingTime.isAcceptableOrUnknown(
          data['reading_time']!,
          _readingTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_readingTimeMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.ArticleScrollPosition map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ArticleScrollPosition(
      id:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      readingTime:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.int,
            data['${effectivePrefix}reading_time'],
          )!,
      progress:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.double,
            data['${effectivePrefix}progress'],
          )!,
    );
  }

  @override
  ArticleScrollPositions createAlias(String alias) {
    return ArticleScrollPositions(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ArticleScrollPosition extends i0.DataClass
    implements i0.Insertable<i1.ArticleScrollPosition> {
  final int id;
  final int readingTime;
  final double progress;
  const ArticleScrollPosition({
    required this.id,
    required this.readingTime,
    required this.progress,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['reading_time'] = i0.Variable<int>(readingTime);
    map['progress'] = i0.Variable<double>(progress);
    return map;
  }

  i1.ArticleScrollPositionsCompanion toCompanion(bool nullToAbsent) {
    return i1.ArticleScrollPositionsCompanion(
      id: i0.Value(id),
      readingTime: i0.Value(readingTime),
      progress: i0.Value(progress),
    );
  }

  factory ArticleScrollPosition.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ArticleScrollPosition(
      id: serializer.fromJson<int>(json['id']),
      readingTime: serializer.fromJson<int>(json['reading_time']),
      progress: serializer.fromJson<double>(json['progress']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reading_time': serializer.toJson<int>(readingTime),
      'progress': serializer.toJson<double>(progress),
    };
  }

  i1.ArticleScrollPosition copyWith({
    int? id,
    int? readingTime,
    double? progress,
  }) => i1.ArticleScrollPosition(
    id: id ?? this.id,
    readingTime: readingTime ?? this.readingTime,
    progress: progress ?? this.progress,
  );
  ArticleScrollPosition copyWithCompanion(
    i1.ArticleScrollPositionsCompanion data,
  ) {
    return ArticleScrollPosition(
      id: data.id.present ? data.id.value : this.id,
      readingTime:
          data.readingTime.present ? data.readingTime.value : this.readingTime,
      progress: data.progress.present ? data.progress.value : this.progress,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticleScrollPosition(')
          ..write('id: $id, ')
          ..write('readingTime: $readingTime, ')
          ..write('progress: $progress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, readingTime, progress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ArticleScrollPosition &&
          other.id == this.id &&
          other.readingTime == this.readingTime &&
          other.progress == this.progress);
}

class ArticleScrollPositionsCompanion
    extends i0.UpdateCompanion<i1.ArticleScrollPosition> {
  final i0.Value<int> id;
  final i0.Value<int> readingTime;
  final i0.Value<double> progress;
  const ArticleScrollPositionsCompanion({
    this.id = const i0.Value.absent(),
    this.readingTime = const i0.Value.absent(),
    this.progress = const i0.Value.absent(),
  });
  ArticleScrollPositionsCompanion.insert({
    this.id = const i0.Value.absent(),
    required int readingTime,
    required double progress,
  }) : readingTime = i0.Value(readingTime),
       progress = i0.Value(progress);
  static i0.Insertable<i1.ArticleScrollPosition> custom({
    i0.Expression<int>? id,
    i0.Expression<int>? readingTime,
    i0.Expression<double>? progress,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (readingTime != null) 'reading_time': readingTime,
      if (progress != null) 'progress': progress,
    });
  }

  i1.ArticleScrollPositionsCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<int>? readingTime,
    i0.Value<double>? progress,
  }) {
    return i1.ArticleScrollPositionsCompanion(
      id: id ?? this.id,
      readingTime: readingTime ?? this.readingTime,
      progress: progress ?? this.progress,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (readingTime.present) {
      map['reading_time'] = i0.Variable<int>(readingTime.value);
    }
    if (progress.present) {
      map['progress'] = i0.Variable<double>(progress.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticleScrollPositionsCompanion(')
          ..write('id: $id, ')
          ..write('readingTime: $readingTime, ')
          ..write('progress: $progress')
          ..write(')'))
        .toString();
  }
}

class ArticlesFts extends i0.Table
    with
        i0.TableInfo<ArticlesFts, i1.ArticlesFt>,
        i0.VirtualTableInfo<ArticlesFts, i1.ArticlesFt> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ArticlesFts(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _titleMeta = const i0.VerificationMeta(
    'title',
  );
  late final i0.GeneratedColumn<String> title = i0.GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _contentMeta = const i0.VerificationMeta(
    'content',
  );
  late final i0.GeneratedColumn<String> content = i0.GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: '',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [title, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles_fts';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ArticlesFt> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => const {};
  @override
  i1.ArticlesFt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ArticlesFt(
      title:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            i0.DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
    );
  }

  @override
  ArticlesFts createAlias(String alias) {
    return ArticlesFts(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
  @override
  String get moduleAndArgs =>
      'fts5(title, content, content=articles, content_rowid=id)';
}

class ArticlesFt extends i0.DataClass implements i0.Insertable<i1.ArticlesFt> {
  final String title;
  final String content;
  const ArticlesFt({required this.title, required this.content});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['title'] = i0.Variable<String>(title);
    map['content'] = i0.Variable<String>(content);
    return map;
  }

  i1.ArticlesFtsCompanion toCompanion(bool nullToAbsent) {
    return i1.ArticlesFtsCompanion(
      title: i0.Value(title),
      content: i0.Value(content),
    );
  }

  factory ArticlesFt.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ArticlesFt(
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
    };
  }

  i1.ArticlesFt copyWith({String? title, String? content}) => i1.ArticlesFt(
    title: title ?? this.title,
    content: content ?? this.content,
  );
  ArticlesFt copyWithCompanion(i1.ArticlesFtsCompanion data) {
    return ArticlesFt(
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesFt(')
          ..write('title: $title, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ArticlesFt &&
          other.title == this.title &&
          other.content == this.content);
}

class ArticlesFtsCompanion extends i0.UpdateCompanion<i1.ArticlesFt> {
  final i0.Value<String> title;
  final i0.Value<String> content;
  final i0.Value<int> rowid;
  const ArticlesFtsCompanion({
    this.title = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  ArticlesFtsCompanion.insert({
    required String title,
    required String content,
    this.rowid = const i0.Value.absent(),
  }) : title = i0.Value(title),
       content = i0.Value(content);
  static i0.Insertable<i1.ArticlesFt> custom({
    i0.Expression<String>? title,
    i0.Expression<String>? content,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.ArticlesFtsCompanion copyWith({
    i0.Value<String>? title,
    i0.Value<String>? content,
    i0.Value<int>? rowid,
  }) {
    return i1.ArticlesFtsCompanion(
      title: title ?? this.title,
      content: content ?? this.content,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (title.present) {
      map['title'] = i0.Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = i0.Variable<String>(content.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesFtsCompanion(')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

i0.Trigger get articlesAi => i0.Trigger(
  'CREATE TRIGGER articles_ai AFTER INSERT ON articles BEGIN INSERT INTO articles_fts ("rowid", title, content) VALUES (new.id, new.title, new.content);END',
  'articles_ai',
);
i0.Trigger get articlesAd => i0.Trigger(
  'CREATE TRIGGER articles_ad AFTER DELETE ON articles BEGIN INSERT INTO articles_fts (articles_fts, "rowid", title, content) VALUES (\'delete\', old.id, old.title, old.content);END',
  'articles_ad',
);
i0.Trigger get articlesAu => i0.Trigger(
  'CREATE TRIGGER articles_au AFTER UPDATE ON articles BEGIN INSERT INTO articles_fts (articles_fts, "rowid", title, content) VALUES (\'delete\', old.id, old.title, old.content);INSERT INTO articles_fts ("rowid", title, content) VALUES (new.id, new.title, new.content);END',
  'articles_au',
);

class ArticleDrift extends i3.ModularAccessor {
  ArticleDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<int> articleIdsForText(
    String query, {
    ArticleIdsForText$predicate? predicate,
  }) {
    var $arrayStartIndex = 2;
    final generatedpredicate = $write(
      predicate?.call(this.articlesFts, this.articles) ??
          const i0.CustomExpression('(TRUE)'),
      hasMultipleTables: true,
      startIndex: $arrayStartIndex,
    );
    $arrayStartIndex += generatedpredicate.amountOfVariables;
    return customSelect(
      'SELECT articles.id FROM articles_fts JOIN articles ON articles.id = articles_fts."rowid" WHERE articles_fts MATCH ?1 AND ${generatedpredicate.sql} ORDER BY rank',
      variables: [
        i0.Variable<String>(query),
        ...generatedpredicate.introducedVariables,
      ],
      readsFrom: {articles, articlesFts, ...generatedpredicate.watchedTables},
    ).map((i0.QueryRow row) => row.read<int>('id'));
  }

  i1.ArticlesFts get articlesFts => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.ArticlesFts>('articles_fts');
  i1.Articles get articles => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.Articles>('articles');
}

typedef ArticleIdsForText$predicate =
    i0.Expression<bool> Function(
      i1.ArticlesFts articles_fts,
      i1.Articles articles,
    );
