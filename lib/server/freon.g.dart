// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreonCredentials _$FreonCredentialsFromJson(Map<String, dynamic> json) =>
    FreonCredentials(
      Uri.parse(json['server'] as String),
      json['apiToken'] as String,
    );

Map<String, dynamic> _$FreonCredentialsToJson(FreonCredentials instance) =>
    <String, dynamic>{
      'server': instance.server.toString(),
      'apiToken': instance.apiToken,
    };
