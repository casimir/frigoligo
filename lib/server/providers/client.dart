import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../wallabag/client.dart';
import '../../wallabag/wallabag.dart';
import '../freon.dart';
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
  Future<WallabagClient?> build() async {
    final session = await ref.watch(sessionProvider.future);
    if (session == null || !session.isValid) return null;

    switch (session.type) {
      case ServerType.freon:
        return FreonWallabagClient(session.freon!);
      case ServerType.wallabag:
        // `session` is not used here because this client as its own session management.
        return WallabagNativeClient(NativeSessionWrapper());
      case ServerType.unknown:
        _log.warning('unknown server type: ${session.type}: ${session.raw}');
        return null;
    }
  }
}
