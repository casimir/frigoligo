import 'package:isar/isar.dart';

import 'article.dart';

part 'article_scroll_position.g.dart';

@collection
class ArticleScrollPosition {
  int id;
  int readingTime;
  double progress;

  ArticleScrollPosition({
    required this.id,
    required this.readingTime,
    required this.progress,
  });

  factory ArticleScrollPosition.fromArticle(Article article, double progress) {
    return ArticleScrollPosition(
      id: article.id,
      readingTime: article.readingTime,
      progress: progress,
    );
  }

  @override
  String toString() {
    return 'ArticleScrollPosition{id: $id, progress: $progress}';
  }
}
