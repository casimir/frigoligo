import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../wallabag/credentials.dart';
import 'freon.dart';

part 'session.g.dart';

enum ServerType {
  freon,
  wallabag,
  unknown,
}

abstract class SaveableCredentials<T> {
  T? get credentials;
  set credentials(T? value);
}

const sessionKey = 'server.session';

@JsonSerializable()
class ServerSession {
  const ServerSession(this.type, {this.freon, this.wallabag});

  final ServerType type;
  final FreonCredentials? freon;
  final Credentials? wallabag;

  factory ServerSession.fromJson(Map<String, dynamic> json) =>
      _$ServerSessionFromJson(json);
  Map<String, dynamic> toJson() => _$ServerSessionToJson(this);

  static Future<ServerSession> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(sessionKey);
    if (raw != null) {
      return ServerSession.fromJson(jsonDecode(raw));
    }
    final legacy = await _loadLegacy();
    if (legacy != null) {
      return ServerSession(ServerType.wallabag, wallabag: legacy);
    }
    return const ServerSession(ServerType.unknown);
  }

  static Future<Credentials?> _loadLegacy() async {
    final manager = CredentialsManager();
    await manager.init();
    await manager.load();
    return manager.credentials;
  }

  Future<bool> save() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(toJson());
    return prefs.setString(sessionKey, encoded);
  }
}
