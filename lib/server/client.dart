import '../wallabag/client.dart';
import '../wallabag/wallabag.dart';
import 'freon.dart';
import 'session.dart';

export '../wallabag/client.dart' show ServerError, WallabagClientEndpoints;

class ServerInstance {
  static WallabagClient? _instance;

  static Future<WallabagClient?> init(ServerSession session) async {
    _instance = switch (session.type) {
      ServerType.freon => FreonClient(session.freon!).wallabag,
      ServerType.wallabag =>
        await WallabagNativeClient.build(credentials: session.wallabag),
      ServerType.unknown => null, // unreachable
    };
    return _instance;
  }

  static WallabagClient get() {
    assert(_instance != null);
    return _instance!;
  }

  static bool get isReady => _instance?.isReady ?? false;
}
