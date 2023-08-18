import 'package:isar/isar.dart';

import 'article.dart';

part 'article_scroll_position.g.dart';

@collection
class ArticleScrollPosition {
  int id;
  int readingTime;
  double position;

  ArticleScrollPosition({
    required this.id,
    required this.readingTime,
    required this.position,
  });

  factory ArticleScrollPosition.fromArticle(Article article, double position) {
    return ArticleScrollPosition(
      id: article.id,
      readingTime: article.readingTime,
      position: position,
    );
  }
}
