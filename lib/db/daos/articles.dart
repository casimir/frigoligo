import 'package:drift/drift.dart';

import '../database.dart';
import '../models/article.dart';

part 'articles.g.dart';

@DriftAccessor(tables: [Articles])
class ArticlesDao extends DatabaseAccessor<DB> with _$ArticlesDaoMixin {
  ArticlesDao(super.db);

  Future<int> updateOne(Article article) {
    return db.transaction(() async {
      var count = await articles.insertOnConflictUpdate(article);

      final position = await db.managers.articleScrollPositions
          .filter((f) => f.id.equals(article.id))
          .getSingleOrNull();
      if (position != null && position.readingTime != article.readingTime) {
        count += await db.articleScrollPositions
            .deleteWhere((f) => f.id.equals(article.id));
      }

      return count;
    });
  }

  Future<void> updateAll(Iterable<Article> allArticles) async {
    final index = {for (final it in allArticles) it.id: it};

    return db.transaction(() async {
      final t1 = db.articleScrollPositions;
      final t2 = db.articles;

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
      count += await db.articles.deleteWhere((f) => f.id.equals(articleId));
      count += await db.articleScrollPositions
          .deleteWhere((f) => f.id.equals(articleId));
      return count;
    });
  }
}
