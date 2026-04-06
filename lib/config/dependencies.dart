import 'package:get_it/get_it.dart';

import '../bridge/article_sheet_bridge.dart';
import '../bridge/auth_gate_bridge.dart';
import '../bridge/log_console_bridge.dart';
import '../bridge/navigation_split_bridge.dart';
import '../bridge/session_details_bridge.dart';
import '../bridge/settings_bridge.dart';
import '../constants.dart';
import '../data/repositories/article_repository.dart';
import '../data/repositories/logger_repository.dart';
import '../data/repositories/query_repository.dart';
import '../data/repositories/remote_action_repository.dart';
import '../data/repositories/server_session_repository.dart';
import '../data/repositories/tag_repository.dart';
import '../data/services/local/storage/config_store_backends/shared_preferences_backend.dart';
import '../data/services/local/storage/config_store_service.dart';
import '../data/services/local/storage/database/database.dart';
import '../data/services/local/storage/logging_storage_service.dart';
import '../data/services/local/storage/storage_service.dart';
import '../data/services/platform/appbadge_service.dart';
import '../data/services/platform/sharing_service.dart';
import '../data/services/platform/urllauncher_service.dart';
import '../domain/repositories.dart';
import '../domain/sync/sync_manager.dart';
import 'logging.dart';

export '../domain/repositories.dart';

final dependencies = GetIt.instance;

void setupDependencies({
  ConfigStoreBackend? withConfigStoreBackend,
  DB? withDB,
}) {
  final d = dependencies;

  // data services

  final configStoreBackend =
      withConfigStoreBackend ?? SharedPreferencesBackend(appGroupId);
  d.registerLazySingleton<ConfigStoreService>(
    () => ConfigStoreService(configStoreBackend),
    dispose: (obj) => obj.dispose(),
  );

  final db = withDB ?? DB();
  d.registerLazySingleton(() => LocalStorageService(db: db));
  d.registerLazySingleton<LoggingStorageService>(
    () => LoggingStorageService(db: db),
  );

  // platorm services

  // if used only in one service it should be handled just like `db`
  d.registerLazySingleton(() => const AppBadgeService());
  d.registerLazySingleton(() => const SharingService());
  d.registerLazySingleton(() => const UrlLauncherService());

  // repositories

  d.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(localStorageService: d.get()),
  );
  d.registerLazySingleton<LoggerRepository>(
    () => LoggerRepositoryImpl(
      loggingStorageService: d.get(),
      startingAppMessage: startingAppMessage,
      maxLogCount: maxLogCount,
    ),
  );
  d.registerLazySingleton<QueryRepository>(
    () => QueryRepositoryImpl(localStorageService: d.get()),
    dispose: (obj) => obj.dispose(),
  );
  d.registerLazySingleton<RemoteActionRepository>(
    () => RemoteActionRepositoryImpl(localStorageService: d.get()),
  );
  d.registerLazySingleton<ServerSessionRepository>(
    () => ServerSessionRepositoryImpl(configStoreService: d.get()),
  );
  d.registerLazySingleton<TagRepository>(
    () => TagRepositoryImpl(localStorageService: d.get()),
  );
}

void setupNativeBridges() {
  final d = dependencies;
  d.registerLazySingleton(
    () => ArticleSheetBridge(
      articleRepository: d.get(),
      tagRepository: d.get(),
      syncManager: SyncManager.instance,
    ),
  );
  d.registerLazySingleton(
    () => AuthGateBridge(serverSessionRepository: d.get()),
  );
  d.registerLazySingleton(() => LogConsoleBridge());
  d.registerLazySingleton(
    () => NavigationSplitBridge(
      configStoreService: d.get(),
      articleRepository: d.get(),
      queryRepository: d.get(),
    ),
    dispose: (obj) => obj.dispose(),
  );
  d.registerLazySingleton(
    () => SessionDetailsBridge(configStoreService: d.get()),
  );
  d.registerLazySingleton(
    () => SettingsBridge(configStoreService: d.get()),
    dispose: (obj) => obj.dispose(),
  );
}
