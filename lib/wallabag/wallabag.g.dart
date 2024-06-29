// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallabag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthTokenBody _$OAuthTokenBodyFromJson(Map<String, dynamic> json) =>
    OAuthTokenBody(
      json['access_token'] as String,
      (json['expires_in'] as num).toInt(),
      json['refresh_token'] as String,
    );
