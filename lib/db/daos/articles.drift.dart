// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:frigoligo/db/database.dart' as i1;
import 'package:frigoligo/db/models/article.drift.dart' as i2;
import 'package:drift/internal/modular.dart' as i3;

mixin $ArticlesDaoMixin on i0.DatabaseAccessor<i1.DB> {
  i2.Articles get articles => i3.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i2.Articles>('articles');
  i2.ArticleScrollPositions get articleScrollPositions =>
      i3.ReadDatabaseContainer(attachedDatabase)
          .resultSet<i2.ArticleScrollPositions>('article_scroll_positions');
}
