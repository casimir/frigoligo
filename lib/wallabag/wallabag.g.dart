// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallabag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthTokenBody _$OAuthTokenBodyFromJson(Map<String, dynamic> json) =>
    OAuthTokenBody(
      json['access_token'] as String,
      json['expires_in'] as int,
      json['refresh_token'] as String,
    );

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
