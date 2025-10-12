import 'package:drift/drift.dart';

import '../database.dart';
import '../models/article.drift.dart';
import 'articles.drift.dart';

@DriftAccessor(include: {'../models/article.drift'})
class ArticlesDao extends DatabaseAccessor<DB> with $ArticlesDaoMixin {
  ArticlesDao(super.attachedDatabase);

  Future<void> updateAll(Iterable<Article> allArticles) async {
    final index = {for (final it in allArticles) it.id: it.toCompanion(false)};

    return db.transaction(() async {
      final t1 = articleScrollPositions;
      final t2 = articles;

      final invalidPositions =
          await (selectOnly(
                  t1,
                ).join([leftOuterJoin(t2, t1.id.equalsExp(t2.id))])
                ..addColumns([t1.id])
                ..where(
                  t1.id.isIn(index.keys) &
                      t1.readingTime.isNotExp(t2.readingTime),
                ))
              .map((row) => row.read(t1.id)!)
              .get();

      await db.batch((batch) {
        batch.insertAllOnConflictUpdate(articles, index.values);
        batch.deleteWhere(t1, (f) => f.id.isIn(invalidPositions));
      });
    });
  }

  Selectable<int> selectArticleIdsForText(
    String text, {
    SearchTextMode mode = SearchTextMode.all,
    Expression<bool> Function(Articles t)? where,
  }) {
    final columnFilter = switch (mode) {
      SearchTextMode.all => '',
      SearchTextMode.title => 'title : ',
      SearchTextMode.content => 'content : ',
    };
    final quotedText = '"$text"';
    final cleanedText = quotedText.trim().split(RegExp(r'\s+')).join(' AND ');
    final suffix = cleanedText.endsWith('*') ? '' : '*'; // ensure some matches
    final query = columnFilter + cleanedText + suffix;
    final predicate = where != null ? (_, t) => where(t) : null;
    return articleDrift.articleIdsForText(query, predicate: predicate);
  }

  Future<Set<int>> getAllIds() {
    return (selectOnly(articles)..addColumns([
      articles.id,
    ])).map((row) => row.read(articles.id)!).get().then((ids) => ids.toSet());
  }

  Future<List<String>> listAllDomains() {
    return (selectOnly(articles, distinct: true)
          ..addColumns([articles.domainName])
          ..where(articles.domainName.isNotNull())
          ..orderBy([OrderingTerm.asc(articles.domainName)]))
        .map((row) => row.read(articles.domainName)!)
        .get();
  }

  Future<int> countUnread() =>
      articles.count(where: (t) => t.archivedAt.isNull()).getSingle();

  Future<void> saveScrollProgress(int articleId, double progress) async {
    await db.transaction(() async {
      final readingTime =
          await (db.articles.selectOnly()
                ..addColumns([articles.readingTime])
                ..where(articles.id.equals(articleId)))
              .map((row) => row.read(articles.readingTime)!)
              .getSingle();
      await db.managers.articleScrollPositions.create(
        (o) => o(
          id: Value(articleId),
          readingTime: readingTime,
          progress: progress,
        ),
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}

enum SearchTextMode { all, title, content }
