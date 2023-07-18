// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallabag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallabagConnectionData _$WallabagConnectionDataFromJson(
        Map<String, dynamic> json) =>
    WallabagConnectionData(
      json['server'] as String,
      json['clientId'] as String,
      json['clientSecret'] as String,
    );

Map<String, dynamic> _$WallabagConnectionDataToJson(
        WallabagConnectionData instance) =>
    <String, dynamic>{
      'server': instance.server,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
    };

OAuthToken _$OAuthTokenFromJson(Map<String, dynamic> json) => OAuthToken(
      json['access_token'] as String,
      secondsOffsetOrTimestamp2Datetime(json['expires_in']),
      json['refresh_token'] as String,
    );

Map<String, dynamic> _$OAuthTokenToJson(OAuthToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn.toIso8601String(),
      'refresh_token': instance.refreshToken,
    };

WallabagPaginatedEntries _$WallabagPaginatedEntriesFromJson(
        Map<String, dynamic> json) =>
    WallabagPaginatedEntries(
      json['page'] as int,
      json['limit'] as int,
      json['pages'] as int,
      json['total'] as int,
      WallabagEmbeddedEntries.fromJson(
          json['_embedded'] as Map<String, dynamic>),
    );

WallabagEmbeddedEntries _$WallabagEmbeddedEntriesFromJson(
        Map<String, dynamic> json) =>
    WallabagEmbeddedEntries(
      (json['items'] as List<dynamic>)
          .map((e) => WallabagEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
