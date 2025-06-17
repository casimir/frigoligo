// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenBearerCredentials _$TokenBearerCredentialsFromJson(
  Map<String, dynamic> json,
) => TokenBearerCredentials(
  Uri.parse(json['server'] as String),
  json['apiToken'] as String,
);

Map<String, dynamic> _$TokenBearerCredentialsToJson(
  TokenBearerCredentials instance,
) => <String, dynamic>{
  'server': instance.server.toString(),
  'apiToken': instance.apiToken,
};
