import '../../constants.dart';
import '../../wallabag/models/entry.dart';
import '../models/article.drift.dart';

extension ArticleExtension on Article {
  StateFilter get stateValue =>
      archivedAt != null ? StateFilter.archived : StateFilter.unread;

  StarredFilter get starredValue =>
      starredAt != null ? StarredFilter.starred : StarredFilter.unstarred;
}

Article articleFromWallabagEntry(WallabagEntry entry) => Article(
      id: entry.id,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      title: entry.title!,
      domainName: entry.domainName,
      url: entry.url!,
      content: entry.content,
      language: entry.language,
      readingTime: entry.readingTime,
      previewPicture: entry.previewPicture,
      archivedAt: entry.archivedAt,
      starredAt: entry.starredAt,
      tags: entry.tags.map((e) => e.label).toList(),
    );

extension ToArticleExtension on WallabagEntry {
  Article toArticle() => articleFromWallabagEntry(this);
}
