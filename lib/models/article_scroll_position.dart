import 'package:isar/isar.dart';

import 'article.dart';

part 'article_scroll_position.g.dart';

@collection
class ArticleScrollPosition {
  Id? id;
  late int readingTime;
  late double progress;

  ArticleScrollPosition();

  factory ArticleScrollPosition.fromArticle(Article article, double progress) {
    return ArticleScrollPosition()
      ..id = article.id
      ..readingTime = article.readingTime
      ..progress = progress;
  }
}
