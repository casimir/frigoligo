import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/models/server_session.dart';
import '../../domain/repositories.dart';
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
  Future<void> save(ServerSession session) async {
    final encoded = jsonEncode(session.toJson());
    return _configStoreService.set(sessionKey, encoded);
  }

  @override
  Future<void> clear() => _configStoreService.remove(sessionKey);
}
