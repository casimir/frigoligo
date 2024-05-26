// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
          ?.map((e) => e as String)
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
