import 'package:frigoligo/constants.dart';
import 'package:frigoligo/wallabag/models/entry.dart';
import 'package:isar/isar.dart';

part 'article.g.dart';

@collection
class Article {
  Id? id;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String title;
  String? domainName;
  late String url;

  late String content;
  String? language;
  late int readingTime;
  String? previewPicture;

  DateTime? archivedAt;
  DateTime? starredAt;
  late List<String> tags;

  Article();

  @ignore
  StateFilter get stateValue =>
      archivedAt != null ? StateFilter.archived : StateFilter.unread;
  @ignore
  StarredFilter get starredValue =>
      starredAt != null ? StarredFilter.starred : StarredFilter.unstarred;

  factory Article.fromWallabagEntry(WallabagEntry entry) {
    return Article()
      ..id = entry.id
      ..createdAt = entry.createdAt
      ..updatedAt = entry.updatedAt
      ..title = entry.title!
      ..domainName = entry.domainName
      ..url = entry.url!
      ..content = entry.content!
      ..language = entry.language
      ..readingTime = entry.readingTime
      ..previewPicture = entry.previewPicture
      ..archivedAt = entry.archivedAt
      ..starredAt = entry.starredAt
      ..tags = entry.tags.map((e) => e.label).toList();
  }
}
