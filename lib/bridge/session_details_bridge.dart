// coverage:ignore-file
import 'dart:async';

import '../config/dependencies.dart';
import '../data/services/local/storage/config_store_service.dart';
import '../data/services/local/storage/storage_service.dart';
import '../data/services/platform/appbadge_service.dart';
import '../domain/client_factory.dart';
import '../pigeon/auth_gate.g.dart';
import '../pigeon/settings.g.dart';
import '../server/clients.dart';

class SessionDetailsBridge implements SessionDetailsFlutterApi {
  SessionDetailsBridge({required ConfigStoreService configStoreService})
    : _configStoreService = configStoreService {
    SessionDetailsFlutterApi.setUp(this);
  }

  final ConfigStoreService _configStoreService;

  @override
  Future<SessionData> getSessionData() async {
    final sessionRepo = dependencies.get<ServerSessionRepository>();
    final storage = dependencies.get<LocalStorageService>();
    final session = sessionRepo.getSession()!;
    final lastSync = await storage.metadata.getLastSyncTS();

    return switch (session.type) {
      ServerType.freon => SessionData(
        serverType: 'freon',
        serverUrl: session.freon!.server.toString(),
        apiToken: session.freon!.apiToken,
        lastSyncTimestamp: lastSync,
      ),
      ServerType.wallabag => SessionData(
        serverType: 'wallabag',
        serverUrl: session.wallabag!.server.toString(),
        clientId: session.wallabag!.clientId,
        clientSecret: session.wallabag!.clientSecret,
        accessToken: session.wallabag!.token?.accessToken,
        tokenExpiration: session.wallabag!.token?.expirationDateTime
            .toIso8601String(),
        lastSyncTimestamp: lastSync,
      ),
      ServerType.local => SessionData(
        serverType: 'local',
        serverUrl: '',
        lastSyncTimestamp: lastSync,
      ),
    };
  }

  @override
  Future<void> logout() async {
    final sessionRepo = dependencies.get<ServerSessionRepository>();
    final storage = dependencies.get<LocalStorageService>();
    final appBadge = dependencies.get<AppBadgeService>();
    await sessionRepo.clear();
    await _configStoreService.clear();
    await storage.database.clear(keepPositions: false);
    await appBadge.clear();
    unawaited(AuthGateApi().requireLogin());
  }

  @override
  Future<void> refreshToken() async {
    final sessionRepo = dependencies.get<ServerSessionRepository>();
    final client = sessionRepo.createClient(userAgent: 'frigoligo');
    if (client is WallabagClient) {
      await client.refreshToken();
    }
  }
}
