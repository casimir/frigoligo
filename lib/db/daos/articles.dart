import 'package:drift/drift.dart';

import '../database.dart';
import '../models/article.drift.dart';
import 'articles.drift.dart';

@DriftAccessor(include: {'../models/article.drift'})
class ArticlesDao extends DatabaseAccessor<DB> with $ArticlesDaoMixin {
  ArticlesDao(super.attachedDatabase);

  Future<int> updateOne(Article article) {
    return db.transaction(() async {
      var count =
          await articles.insertOnConflictUpdate(article.toCompanion(false));

      final position = await db.managers.articleScrollPositions
          .filter((f) => f.id.equals(article.id))
          .getSingleOrNull();
      if (position != null && position.readingTime != article.readingTime) {
        count += await articleScrollPositions
            .deleteWhere((f) => f.id.equals(article.id));
      }

      return count;
    });
  }

  Future<void> updateAll(Iterable<Article> allArticles) async {
    final index = {for (final it in allArticles) it.id: it.toCompanion(false)};

    return db.transaction(() async {
      final t1 = articleScrollPositions;
      final t2 = articles;

      final invalidPositions = await (selectOnly(t1)
              .join([leftOuterJoin(t2, t1.id.equalsExp(t2.id))])
            ..addColumns([t1.id])
            ..where(t1.id.isIn(index.keys) &
                t1.readingTime.isNotExp(t2.readingTime)))
          .map((row) => row.read(t1.id)!)
          .get();

      await db.batch((batch) {
        batch.insertAllOnConflictUpdate(articles, index.values);
        batch.deleteWhere(t1, (f) => f.id.isIn(invalidPositions));
      });
    });
  }

  Future<int> deleteOne(int articleId) {
    return db.transaction(() async {
      var count = 0;
      count += await articles.deleteWhere((f) => f.id.equals(articleId));
      count += await articleScrollPositions
          .deleteWhere((f) => f.id.equals(articleId));
      return count;
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
    final cleanedText = text.trim().split(RegExp(r'\s+')).join(' AND ');
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

  Future<List<String>> listAllTags() async {
    final tagLists = await (articles.selectOnly()..addColumns([articles.tags]))
        .map((row) => row.readWithConverter(articles.tags)!)
        .get();
    final tags = tagLists.expand((it) => it).toSet().toList();
    tags.sort();
    return tags;
  }

  Future<int> countUnread() =>
      articles.count(where: (t) => t.archivedAt.isNull()).getSingle();

  Future<void> saveScrollProgress(Article article, double progress) async {
    await DB().managers.articleScrollPositions.create(
          (o) => o(
            id: Value(article.id),
            readingTime: article.readingTime,
            progress: progress,
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}

enum SearchTextMode { all, title, content }
