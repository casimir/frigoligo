// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credentials _$CredentialsFromJson(Map<String, dynamic> json) => Credentials(
      Uri.parse(json['server'] as String),
      json['clientId'] as String,
      json['clientSecret'] as String,
      token: json['token'] == null
          ? null
          : OAuthToken.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{
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
