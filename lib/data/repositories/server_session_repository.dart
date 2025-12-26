import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/repositories.dart';
import '../../server/session.dart';
import '../../server/src/clients/wallabag.dart';
import '../../server/src/server_types.dart';
import '../services/local/storage/config_store_service.dart';

const _keyPrefix = kDebugMode ? 'debug.' : '';
const sessionKey = '${_keyPrefix}server.session';

class ServerSessionRepositoryImpl implements ServerSessionRepository {
  ServerSessionRepositoryImpl({required ConfigStoreService configStoreService})
    : _configStoreService = configStoreService;

  final ConfigStoreService _configStoreService;

  @override
  ServerSession? getSession() {
    final raw = _configStoreService.get(sessionKey);
    return raw != null ? ServerSession.fromRawJson(raw) : null;
  }

  @override
  Stream<ServerSession?> watchSession() {
    return _configStoreService.watch<String>(sessionKey).map((raw) {
      return raw != null ? ServerSession.fromRawJson(raw) : null;
    });
  }

  @override
  Future<void> save(ServerSession session) async {
    final encoded = jsonEncode(session.toJson());
    return _configStoreService.set(sessionKey, encoded);
  }

  @override
  Future<void> clear() => _configStoreService.remove(sessionKey);
}

class NativeSessionWrapper extends UpdatableWallabagCredentialsAdapter {
  NativeSessionWrapper(ServerSessionRepository serverSessionRepository)
    : _serverSessionRepository = serverSessionRepository;

  final ServerSessionRepository _serverSessionRepository;

  @override
  Future<WallabagCredentials?> read() async {
    final session = _serverSessionRepository.getSession();
    return session?.type == ServerType.wallabag ? session!.wallabag : null;
  }

  @override
  Future<void> write(WallabagCredentials credentials) async {
    final session = ServerSession(ServerType.wallabag, wallabag: credentials);
    await _serverSessionRepository.save(session);
  }
}
