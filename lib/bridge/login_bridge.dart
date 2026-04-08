// coverage:ignore-file
import 'dart:async';

import '../config/dependencies.dart';
import '../data/services/local/storage/storage_service.dart';
import '../domain/models/server_session.dart';
import '../domain/sync/sync_manager.dart';
import '../pages/login_flow/demo_mode.dart';
import '../pigeon/login.g.dart';
import '../server/check.dart';
import '../server/clients.dart';

class LoginBridge implements LoginFlutterApi {
  LoginBridge({required ServerSessionRepository serverSessionRepository})
    : _repo = serverSessionRepository {
    LoginFlutterApi.setUp(this);
  }

  final ServerSessionRepository _repo;

  @override
  Future<ServerCheckResult> checkServer(String url, bool selfSigned) async {
    final check = await checkServerState(url, selfSigned);
    return ServerCheckResult(
      serverType: check.probeResult?.type.name,
      serverUrl: check.uri?.toString(),
      version: check.probeResult?.version,
      selfSigned: check.selfSigned,
      errorKind: check.errorKind?.name,
      errorMessage: check.errorKind == ServerCheckErrorKind.unknown
          ? check.error?.toString()
          : null,
    );
  }

  @override
  Future<String?> loginWallabag(
    String url,
    bool selfSigned,
    String clientId,
    String clientSecret,
    String username,
    String password,
  ) async {
    try {
      final uri = Uri.parse(url);
      final credentials = WallabagCredentials(uri, clientId, clientSecret);
      final credsAdapter = InMemoryCredentials(credentials);
      final wallabag = WallabagClient(
        credsAdapter,
        selfSignedHost: selfSigned ? uri.host : null,
      );
      await wallabag.fetchToken(username, password);
      final session = ServerSession(
        ServerType.wallabag,
        wallabag: credsAdapter.credentials,
        selfSignedHost: selfSigned ? uri.host : null,
      );
      await _repo.save(session);
      unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> loginFreon(String url, bool selfSigned, String token) async {
    try {
      final uri = Uri.parse(url);
      final freonCreds = TokenBearerCredentials(uri, token);
      final freon = FreonClient(
        freonCreds,
        selfSignedHost: selfSigned ? uri.host : null,
      );
      await freon.getInfo();
      final session = ServerSession(
        ServerType.freon,
        freon: freonCreds,
        selfSignedHost: selfSigned ? uri.host : null,
      );
      await _repo.save(session);
      unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<void> loadDemoMode() async {
    await setupDemoMode(dependencies.get<LocalStorageService>(), _repo);
    unawaited(SyncManager.instance.synchronize(withFinalRefresh: true));
  }
}
