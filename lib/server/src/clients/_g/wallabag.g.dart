// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../wallabag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthTokenBody _$OAuthTokenBodyFromJson(Map<String, dynamic> json) =>
    OAuthTokenBody(
      json['access_token'] as String,
      (json['expires_in'] as num).toInt(),
      json['refresh_token'] as String,
    );

WallabagCredentials _$WallabagCredentialsFromJson(Map<String, dynamic> json) =>
    WallabagCredentials(
      Uri.parse(json['server'] as String),
      json['clientId'] as String,
      json['clientSecret'] as String,
      token:
          json['token'] == null
              ? null
              : OAuthToken.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WallabagCredentialsToJson(
  WallabagCredentials instance,
) => <String, dynamic>{
  'server': instance.server.toString(),
  'clientId': instance.clientId,
  'clientSecret': instance.clientSecret,
  'token': instance.token,
};

OAuthToken _$OAuthTokenFromJson(Map<String, dynamic> json) => OAuthToken(
  json['accessToken'] as String,
  (json['expiresAt'] as num).toInt(),
  json['refreshToken'] as String,
);

Map<String, dynamic> _$OAuthTokenToJson(OAuthToken instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'expiresAt': instance.expiresAt,
      'refreshToken': instance.refreshToken,
    };
