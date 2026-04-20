// coverage:ignore-file
import 'package:logging/logging.dart';

import '../config/dependencies.dart';
import '../data/services/local/storage/config_store_service.dart';
import '../domain/sync/sync_manager.dart';
import '../pigeon/system.g.dart';

class SystemBridge implements SystemFlutterApi {
  SystemBridge() {
    SystemFlutterApi.setUp(this);
  }

  static final _levelByName = {for (final l in Level.LEVELS) l.name: l};

  @override
  void log(LogData entry) {
    final level = _levelByName[entry.level] ?? Level.INFO;
    Logger(entry.loggerName).log(level, entry.message, entry.error);
  }

  @override
  Future<void> onAppResumed() async {
    await dependencies.get<ConfigStoreService>().reload();
    await SyncManager.instance.synchronize(withFinalRefresh: true);
  }

  @override
  Future<void> onBackgroundFetch() async {
    await SyncManager.instance.synchronize(withFinalRefresh: true);
  }
}
