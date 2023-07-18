import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class WallabagTag {
  final int id;
  final String label;
  final String slug;

  const WallabagTag(
    this.id,
    this.label,
    this.slug,
  );

  factory WallabagTag.fromJson(Map<String, dynamic> json) =>
      _$WallabagTagFromJson(json);
  Map<String, dynamic> toJson() => _$WallabagTagToJson(this);
}
