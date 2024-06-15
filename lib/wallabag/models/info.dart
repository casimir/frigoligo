import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WallabagInfo {
  final String appname;
  final String version;
  final bool? allowedRegistration;

  const WallabagInfo(this.appname, this.version, this.allowedRegistration);

  factory WallabagInfo.fromJson(Map<String, dynamic> json) =>
      _$WallabagInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WallabagInfoToJson(this);
}
