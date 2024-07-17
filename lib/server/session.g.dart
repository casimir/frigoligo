// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerSession _$ServerSessionFromJson(Map<String, dynamic> json) =>
    ServerSession(
      $enumDecode(_$ServerTypeEnumMap, json['type']),
      wallabag: json['wallabag'] == null
          ? null
          : Credentials.fromJson(json['wallabag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServerSessionToJson(ServerSession instance) =>
    <String, dynamic>{
      'type': _$ServerTypeEnumMap[instance.type]!,
      'wallabag': instance.wallabag,
    };

const _$ServerTypeEnumMap = {
  ServerType.wallabag: 'wallabag',
  ServerType.unknown: 'unknown',
};
