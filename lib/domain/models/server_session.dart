import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../server/clients.dart';

part '_g/server_session.g.dart';

@JsonSerializable()
class ServerSession {
  ServerSession(
    this.type, {
    this.freon,
    this.wallabag,
    this.selfSignedHost,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? raw;
  final ServerType type;
  final TokenBearerCredentials? freon;
  final WallabagCredentials? wallabag;
  final String? selfSignedHost;

  bool get isValid => switch (type) {
    ServerType.wallabag => wallabag?.token != null,
    _ => true,
  };

  ServerSession invalidated() {
    if (type == ServerType.wallabag) {
      final invalidatedWallabag = wallabag;
      invalidatedWallabag?.token = null;
      return ServerSession(
        type,
        freon: null,
        wallabag: invalidatedWallabag,
        selfSignedHost: selfSignedHost,
      );
    } else {
      return this;
    }
  }

  factory ServerSession.fromRawJson(String raw) =>
      _$ServerSessionFromJson(jsonDecode(raw))..raw = raw;
  Map<String, dynamic> toJson() => _$ServerSessionToJson(this);
}
