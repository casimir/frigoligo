import '../server/clients.dart';
import 'models/server_session.dart';
import 'repositories.dart';

extension ClientFactory on ServerSessionRepository {
  ApiClient createClient({required String userAgent}) {
    final session = getSession();
    if (session == null) {
      throw StateError('No active session');
    }
    if (!session.isValid) {
      throw const ServerError('Invalid session', manuallyInvalidated: true);
    }

    switch (session.type) {
      case ServerType.freon:
        return FreonClient(
          session.freon!,
          userAgent: userAgent,
          selfSignedHost: session.selfSignedHost,
        );
      case ServerType.wallabag:
        return WallabagClient(
          NativeSessionWrapper(this),
          userAgent: userAgent,
          selfSignedHost: session.selfSignedHost,
        );
    }
  }
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
