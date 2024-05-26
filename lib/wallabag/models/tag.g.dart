// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
