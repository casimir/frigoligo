import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app_info.dart';
import '../clients.dart';
import '../session.dart';

part 'client.g.dart';

final _log = Logger('server.client');

@riverpod
class Session extends _$Session {
  @override
  Future<ServerSession?> build() => ServerSession.load();

  Future<void> invalidate() async {
    final session = await ServerSession.load();
    if (session?.type == ServerType.wallabag && session!.wallabag != null) {
      session.wallabag!.token = null;
      await session.save();
    }
    ref.invalidateSelf();
  }

  Future<void> logout() async {
    ServerSession.clear();
    state = const AsyncValue.data(null);
  }
}

@riverpod
class Client extends _$Client {
  @override
  Future<ApiClient?> build() async {
    final session = await ref.watch(sessionProvider.future);
    if (session == null || !session.isValid) return null;

    switch (session.type) {
      case ServerType.freon:
        return FreonClient(
          session.freon!,
          userAgent: AppInfo.userAgent,
          selfSignedHost: session.selfSignedHost,
        );
      case ServerType.readeck:
        _log.warning('not implemented: ${session.type}: ${session.raw}');
        return null;
      case ServerType.wallabag:
        // `session` is not used here because this client manages its own
        return WallabagClient(
          NativeSessionWrapper(),
          userAgent: AppInfo.userAgent,
          selfSignedHost: session.selfSignedHost,
        );
      case ServerType.unknown:
        _log.warning('unknown server type: ${session.type}: ${session.raw}');
        return null;
    }
  }
}
