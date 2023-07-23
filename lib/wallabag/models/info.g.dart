// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallabagInfo _$WallabagInfoFromJson(Map<String, dynamic> json) => WallabagInfo(
      json['appname'] as String,
      json['version'] as String,
      json['allowed_registration'] as bool,
    );

Map<String, dynamic> _$WallabagInfoToJson(WallabagInfo instance) =>
    <String, dynamic>{
      'appname': instance.appname,
      'version': instance.version,
      'allowed_registration': instance.allowedRegistration,
    };
