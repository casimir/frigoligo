// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file


part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallabagAnnotation _$WallabagAnnotationFromJson(Map<String, dynamic> json) =>
    WallabagAnnotation(
      (json['id'] as num).toInt(),
      json['annotator_schema_version'] as String,
      DateTime.parse(json['created_at'] as String),
      DateTime.parse(json['updated_at'] as String),
      json['quote'] as String?,
      (json['ranges'] as List<dynamic>)
          .map(
            (e) => WallabagAnnotationRange.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      json['text'] as String,
      json['user'] as String?,
    );

Map<String, dynamic> _$WallabagAnnotationToJson(WallabagAnnotation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'annotator_schema_version': instance.annotatorSchemaVersion,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'quote': instance.quote,
      'ranges': instance.ranges,
      'text': instance.text,
      'user': instance.user,
    };

WallabagAnnotationRange _$WallabagAnnotationRangeFromJson(
  Map<String, dynamic> json,
) => WallabagAnnotationRange(
  json['start'] as String?,
  json['end'] as String?,
  _magicInt(json['start_offset']),
  _magicInt(json['end_offset']),
);

Map<String, dynamic> _$WallabagAnnotationRangeToJson(
  WallabagAnnotationRange instance,
) => <String, dynamic>{
  'start': instance.start,
  'end': instance.end,
  'start_offset': instance.startOffset,
  'end_offset': instance.endOffset,
};

WallabagEntry _$WallabagEntryFromJson(Map<String, dynamic> json) =>
    WallabagEntry(
      (json['id'] as num).toInt(),
      DateTime.parse(json['created_at'] as String),
      DateTime.parse(json['updated_at'] as String),
      json['title'] as String?,
      json['domain_name'] as String?,
      json['content'] as String?,
      json['language'] as String?,
      (json['reading_time'] as num).toInt(),
      json['preview_picture'] as String?,
      int2bool((json['is_archived'] as num).toInt()),
      json['archived_at'] == null
          ? null
          : DateTime.parse(json['archived_at'] as String),
      int2bool((json['is_starred'] as num).toInt()),
      json['starred_at'] == null
          ? null
          : DateTime.parse(json['starred_at'] as String),
      (json['tags'] as List<dynamic>)
          .map((e) => WallabagTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['annotations'] as List<dynamic>?)
          ?.map((e) => WallabagAnnotation.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['url'] as String?,
      json['hashed_url'] as String?,
      json['origin_url'] as String?,
      json['given_url'] as String?,
      json['hashed_given_url'] as String?,
      json['is_public'] as bool,
      json['uid'] as String?,
      json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      (json['published_by'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      (json['user_id'] as num).toInt(),
      json['user_name'] as String,
      json['user_email'] as String,
      json['mimetype'] as String?,
      json['http_status'] as String?,
      (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      ),
    );

Map<String, dynamic> _$WallabagEntryToJson(WallabagEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'title': instance.title,
      'domain_name': instance.domainName,
      'content': instance.content,
      'language': instance.language,
      'reading_time': instance.readingTime,
      'preview_picture': instance.previewPicture,
      'is_archived': instance.isArchived,
      'archived_at': instance.archivedAt?.toIso8601String(),
      'is_starred': instance.isStarred,
      'starred_at': instance.starredAt?.toIso8601String(),
      'tags': instance.tags,
      'annotations': instance.annotations,
      'url': instance.url,
      'hashed_url': instance.hashedUrl,
      'origin_url': instance.originUrl,
      'given_url': instance.givenUrl,
      'hashed_given_url': instance.hashedGivenUrl,
      'is_public': instance.isPublic,
      'uid': instance.uid,
      'published_at': instance.publishedAt?.toIso8601String(),
      'published_by': instance.publishedBy,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_email': instance.userEmail,
      'mimetype': instance.mimeType,
      'http_status': instance.httpStatus,
      'headers': instance.headers,
    };

WallabagInfo _$WallabagInfoFromJson(Map<String, dynamic> json) => WallabagInfo(
  json['appname'] as String,
  json['version'] as String,
  json['allowed_registration'] as bool?,
);

Map<String, dynamic> _$WallabagInfoToJson(WallabagInfo instance) =>
    <String, dynamic>{
      'appname': instance.appname,
      'version': instance.version,
      'allowed_registration': instance.allowedRegistration,
    };

WallabagTag _$WallabagTagFromJson(Map<String, dynamic> json) => WallabagTag(
  (json['id'] as num).toInt(),
  json['label'] as String,
  json['slug'] as String,
);

Map<String, dynamic> _$WallabagTagToJson(WallabagTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'slug': instance.slug,
    };
