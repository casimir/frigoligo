import 'package:json_annotation/json_annotation.dart';

part '_g/types.g.dart';

bool int2bool(int value) => value == 1;

@JsonSerializable()
class WallabagAnnotation {
  final int id;
  @JsonKey(name: 'annotator_schema_version')
  final String annotatorSchemaVersion;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String? quote;
  final List<WallabagAnnotationRange> ranges;
  final String text;
  final String? user;

  const WallabagAnnotation(
    this.id,
    this.annotatorSchemaVersion,
    this.createdAt,
    this.updatedAt,
    this.quote,
    this.ranges,
    this.text,
    this.user,
  );

  factory WallabagAnnotation.fromJson(Map<String, dynamic> json) =>
      _$WallabagAnnotationFromJson(json);
  Map<String, dynamic> toJson() => _$WallabagAnnotationToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class WallabagAnnotationRange {
  final String? start;
  final String? end;
  @JsonKey(fromJson: _magicInt)
  final int? startOffset;
  @JsonKey(fromJson: _magicInt)
  final int? endOffset;

  const WallabagAnnotationRange(
    this.start,
    this.end,
    this.startOffset,
    this.endOffset,
  );

  factory WallabagAnnotationRange.fromJson(Map<String, dynamic> json) =>
      _$WallabagAnnotationRangeFromJson(json);
  Map<String, dynamic> toJson() => _$WallabagAnnotationRangeToJson(this);
}

int? _magicInt(dynamic value) {
  if (value == null) return null;
  return switch (value) {
    int i => i,
    String s => int.parse(s),
    _ => throw Exception('Invalid type ${value.runtimeType}'),
  };
}

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

@JsonSerializable(fieldRename: FieldRename.snake)
class WallabagInfo {
  final String appname;
  final String version;
  final bool? allowedRegistration;

  const WallabagInfo(this.appname, this.version, this.allowedRegistration);

  factory WallabagInfo.fromJson(Map<String, dynamic> json) =>
      _$WallabagInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WallabagInfoToJson(this);
}

@JsonSerializable()
class WallabagTag {
  final int id;
  final String label;
  final String slug;

  const WallabagTag(this.id, this.label, this.slug);

  factory WallabagTag.fromJson(Map<String, dynamic> json) =>
      _$WallabagTagFromJson(json);
  Map<String, dynamic> toJson() => _$WallabagTagToJson(this);
}
