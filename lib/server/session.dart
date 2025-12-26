import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'clients.dart';

part '_g/session.g.dart';

@JsonSerializable()
class ServerSession with EquatableMixin {
  ServerSession(this.type, {useSelfSigned = false, this.freon, this.wallabag})
    : selfSignedHost = useSelfSigned
          ? freon?.server.host ?? wallabag?.server.host
          : null;

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
        useSelfSigned: selfSignedHost != null,
        freon: null,
        wallabag: invalidatedWallabag,
      );
    } else {
      return this;
    }
  }

  @override
  List<Object?> get props => [type, freon, wallabag, selfSignedHost];

  factory ServerSession.fromRawJson(String raw) =>
      _$ServerSessionFromJson(jsonDecode(raw))..raw = raw;
  Map<String, dynamic> toJson() => _$ServerSessionToJson(this);
}
