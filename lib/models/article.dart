import 'package:frigoligo/constants.dart';
import 'package:frigoligo/wallabag/models/entry.dart';
import 'package:isar/isar.dart';

part 'article.g.dart';

@collection
class Article {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String title;
  String? domainName;
  String url;

  String? content;
  String? language;
  int readingTime;
  String? previewPicture;

  DateTime? archivedAt;
  DateTime? starredAt;
  List<String> tags;

  Article({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    this.domainName,
    required this.url,
    this.content,
    this.language,
    this.readingTime = 0,
    this.previewPicture,
    this.archivedAt,
    this.starredAt,
    this.tags = const [],
  });

  // ignore: unused_element
  StateFilter get stateValue =>
      archivedAt != null ? StateFilter.archived : StateFilter.unread;

  // ignore: unused_element
  StarredFilter get starredValue =>
      starredAt != null ? StarredFilter.starred : StarredFilter.unstarred;

  factory Article.fromWallabagEntry(WallabagEntry entry) {
    return Article(
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
  }
}
