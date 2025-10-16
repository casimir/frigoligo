import 'package:get_it/get_it.dart';

import '../data/repositories/article_repository.dart';
import '../data/repositories/logger_repository.dart';
import '../data/repositories/query_repository.dart';
import '../data/repositories/tag_repository.dart';
import '../data/services/local/storage/database/database.dart';
import '../data/services/local/storage/logging_storage_service.dart';
import '../data/services/local/storage/storage_service.dart';
import '../data/services/platform/sharing_service.dart';
import '../data/services/platform/urllauncher_service.dart';
import '../domain/repositories.dart';
import 'logging.dart';

export '../domain/repositories.dart';

final dependencies = GetIt.instance;

void setupDependencies({DB? withDB}) {
  final d = dependencies;

  // data services

  final db = withDB ?? DB();
  d.registerLazySingleton(() => LocalStorageService(db: db));
  d.registerLazySingleton<LoggingStorageService>(
    () => LoggingStorageService(db: db),
  );

  // platorm services

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
  d.registerLazySingleton<TagRepository>(
    () => TagRepositoryImpl(localStorageService: d.get()),
  );
}
