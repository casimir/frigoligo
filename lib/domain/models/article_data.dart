import 'package:equatable/equatable.dart';

class ArticleData with EquatableMixin {
  const ArticleData({
    required this.id,
    required this.title,
    required this.domainName,
    required this.url,
    required this.hasContent,
    required this.readingTime,
    required this.previewPicture,
    required this.tags,
    required this.isArchived,
    required this.isStarred,
  });

  final int id;
  final String title;
  final String? domainName;
  final String url;
  final bool hasContent;
  final int readingTime;
  final String? previewPicture;
  final List<String> tags;
  final bool isArchived;
  final bool isStarred;

  @override
  List<Object?> get props => [
    id,
    title,
    domainName,
    url,
    hasContent,
    readingTime,
    previewPicture,
    tags,
    isArchived,
    isStarred,
  ];
}
