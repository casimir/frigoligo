// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file


part of 'endpoints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallabagPaginatedEntries _$WallabagPaginatedEntriesFromJson(
  Map<String, dynamic> json,
) => WallabagPaginatedEntries(
  (json['page'] as num).toInt(),
  (json['limit'] as num).toInt(),
  (json['pages'] as num).toInt(),
  (json['total'] as num).toInt(),
  WallabagEmbeddedEntries.fromJson(json['_embedded'] as Map<String, dynamic>),
);

WallabagEmbeddedEntries _$WallabagEmbeddedEntriesFromJson(
  Map<String, dynamic> json,
) => WallabagEmbeddedEntries(
  (json['items'] as List<dynamic>)
      .map((e) => WallabagEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
);
