import 'package:json_annotation/json_annotation.dart';

import 'annotation.dart';
import 'tag.dart';

part 'entry.g.dart';

bool int2bool(int value) => value == 1;

@JsonSerializable()
class WallabagEntry {
  // base
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String? title;
  @JsonKey(name: 'domain_name')
  final String? domainName;

  // content data
  final String? content;
  final String? language;
  @JsonKey(name: 'reading_time')
  final int readingTime;
  @JsonKey(name: 'preview_picture')
  final String? previewPicture;

  // article flags
  @JsonKey(name: 'is_archived', fromJson: int2bool)
  final bool isArchived;
  @JsonKey(name: 'archived_at')
  final DateTime? archivedAt;
  @JsonKey(name: 'is_starred', fromJson: int2bool)
  final bool isStarred;
  @JsonKey(name: 'starred_at')
  final DateTime? starredAt;

  // tags
  final List<WallabagTag> tags;

  // annotations
  final List<WallabagAnnotation>? annotations;

  // urls
  final String? url; // this is the final url
  @JsonKey(name: 'hashed_url')
  final String? hashedUrl;
  @JsonKey(name: 'origin_url')
  final String? originUrl;
  @JsonKey(name: 'given_url')
  final String? givenUrl; // the url provided by the user
  @JsonKey(name: 'hashed_given_url')
  final String? hashedGivenUrl;

  // for published entries (only when isPublic is true)
  @JsonKey(name: 'is_public')
  final bool isPublic;
  final String? uid;
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;
  @JsonKey(name: 'published_by')
  final List<String?>? publishedBy;

  // user data
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'user_name')
  final String userName;
  @JsonKey(name: 'user_email')
  final String userEmail;

  // fetching data
  @JsonKey(name: 'mimetype')
  final String? mimeType;
  @JsonKey(name: 'http_status')
  final String? httpStatus;
  final Map<String, String?>? headers;

  // ignored fields
  // _links

  const WallabagEntry(
    // base
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.domainName,
    // content data
    this.content,
    this.language,
    this.readingTime,
    this.previewPicture,
    // article flags
    this.isArchived,
    this.archivedAt,
    this.isStarred,
    this.starredAt,
    // tags
    this.tags,
    // annotations
    this.annotations,
    // urls
    this.url,
    this.hashedUrl,
    this.originUrl,
    this.givenUrl,
    this.hashedGivenUrl,
    // published entries
    this.isPublic,
    this.uid,
    this.publishedAt,
    this.publishedBy,
    // user data
    this.userId,
    this.userName,
    this.userEmail,
    // fetching data
    this.mimeType,
    this.httpStatus,
    this.headers,
  );

  factory WallabagEntry.fromJson(Map<String, dynamic> json) =>
      _$WallabagEntryFromJson(json);
  Map<String, dynamic> toJson() => _$WallabagEntryToJson(this);
}
