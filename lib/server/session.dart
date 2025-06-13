import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import 'clients.dart';

part 'session.g.dart';

enum ServerType { unknown, freon, readeck, wallabag }

const _keyPrefix = kDebugMode ? 'debug.' : '';
const sessionKey = '${_keyPrefix}server.session';
const legacyCredentialsKey = '${_keyPrefix}wallabag.credentials';

@JsonSerializable()
class ServerSession {
  ServerSession(this.type, {useSelfSigned = false, this.freon, this.wallabag})
    : selfSignedHost =
          useSelfSigned ? freon?.server.host ?? wallabag?.server.host : null;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? raw;
  final ServerType type;
  final TokenBearerCredentials? freon;
  WallabagCredentials? wallabag;
  final String? selfSignedHost;

  bool get isValid => switch (type) {
    ServerType.wallabag => wallabag?.token != null,
    _ => true,
  };

  factory ServerSession.fromJson(Map<String, dynamic> json) =>
      _$ServerSessionFromJson(json);
  Map<String, dynamic> toJson() => _$ServerSessionToJson(this);

  @override
  String toString() => 'ServerSession($type, $wallabag)';

  Future<void> save() async {
    final encoded = jsonEncode(toJson());
    if (UniversalPlatform.isIOS) {
      await SharedPreferenceAppGroup.setString(sessionKey, encoded);
    } else {
      await SharedPreferences.getInstance().then(
        (prefs) => prefs.setString(sessionKey, encoded),
      );
    }
  }

  static Future<ServerSession?> load() async {
    final raw = await _spLoadString(sessionKey);
    final session =
        raw != null ? ServerSession.fromJson(jsonDecode(raw)) : null;

    if (session != null) {
      session.raw = raw;
    }

    return session;
  }

  static Future<void> clear() => _spRemove(sessionKey);
}

Future<String?> _spLoadString(String key) {
  if (UniversalPlatform.isIOS) {
    return SharedPreferenceAppGroup.getString(key);
  } else {
    return SharedPreferences.getInstance().then(
      (prefs) => prefs.getString(key),
    );
  }
}

Future<void> _spRemove(String key) async {
  if (UniversalPlatform.isIOS) {
    await SharedPreferenceAppGroup.remove(key);
  } else {
    await SharedPreferences.getInstance().then((prefs) => prefs.remove(key));
  }
}

class NativeSessionWrapper extends UpdatableWallabagCredentialsAdapter {
  @override
  Future<WallabagCredentials?> read() async {
    final session = await ServerSession.load();
    return session?.type == ServerType.wallabag ? session!.wallabag : null;
  }

  @override
  Future<void> write(WallabagCredentials credentials) async {
    final session = ServerSession(ServerType.wallabag, wallabag: credentials);
    await session.save();
  }
}
