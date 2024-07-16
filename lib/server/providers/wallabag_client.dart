import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../wallabag/client.dart';
import '../../wallabag/wallabag.dart';
import '../session.dart';

part 'wallabag_client.g.dart';

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
    if (session == null) return null;

    switch (session.type) {
      case ServerType.wallabag:
        // `session` is not used here because this client as its own session management.
        return WallabagNativeClient(NativeSessionWrapper());
      case ServerType.unknown:
        // TODO throw an error or at least log a warning
        return null;
    }
  }
}
