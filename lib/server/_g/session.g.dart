// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file


part of '../session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerSession _$ServerSessionFromJson(Map<String, dynamic> json) =>
    ServerSession(
      $enumDecode(_$ServerTypeEnumMap, json['type']),
      freon:
          json['freon'] == null
              ? null
              : TokenBearerCredentials.fromJson(
                json['freon'] as Map<String, dynamic>,
              ),
      wallabag:
          json['wallabag'] == null
              ? null
              : WallabagCredentials.fromJson(
                json['wallabag'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$ServerSessionToJson(ServerSession instance) =>
    <String, dynamic>{
      'type': _$ServerTypeEnumMap[instance.type]!,
      'freon': instance.freon,
      'wallabag': instance.wallabag,
    };

const _$ServerTypeEnumMap = {
  ServerType.freon: 'freon',
  ServerType.wallabag: 'wallabag',
};
