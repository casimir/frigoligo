import '../data/repositories/server_session_repository.dart';
import '../server/clients.dart';
import 'repositories.dart';

extension ClientFactory on ServerSessionRepository {
  ApiClient? createClient({required String userAgent}) {
    final session = getSession();
    if (session == null || !session.isValid) return null;

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
