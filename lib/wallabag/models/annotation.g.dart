// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation.dart';

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
          .map((e) =>
              WallabagAnnotationRange.fromJson(e as Map<String, dynamic>))
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
        Map<String, dynamic> json) =>
    WallabagAnnotationRange(
      json['start'] as String?,
      json['end'] as String?,
      _magicInt(json['start_offset']),
      _magicInt(json['end_offset']),
    );

Map<String, dynamic> _$WallabagAnnotationRangeToJson(
        WallabagAnnotationRange instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'start_offset': instance.startOffset,
      'end_offset': instance.endOffset,
    };
