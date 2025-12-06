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

  Future<Set<int>> getAllIds() {
    return (selectOnly(articles)..addColumns([
      articles.id,
    ])).map((row) => row.read(articles.id)!).get().then((ids) => ids.toSet());
  }

  Future<int> countUnread() =>
      articles.count(where: (t) => t.archivedAt.isNull()).getSingle();
}

enum SearchTextMode { all, title, content }
