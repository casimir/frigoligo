import 'package:get_it/get_it.dart';

import '../data/repositories/logger_repository.dart';
import '../data/services/local/storage/database/database.dart';
import '../data/services/local/storage/logging_storage_service.dart';
import '../data/services/local/storage/storage_service.dart';
import '../data/services/platform/sharing/sharing_service.dart';
import '../domain/repositories.dart';
import 'logging.dart';

export '../domain/repositories.dart';

final dependencies = GetIt.instance;

void setupDependencies() {
  final d = dependencies;

  // data services

  final db = DB();
  d.registerLazySingleton(() => LocalStorageService(db: db));
  d.registerLazySingleton<LoggingStorageService>(
    () => LoggingStorageServiceImpl(db: db),
  );

  // platorm services

  d.registerLazySingleton(() => SharingService());

  // repositories

  d.registerLazySingleton<LoggerRepository>(
    () => LoggerRepositoryImpl(
      loggingStorageService: d.get(),
      startingAppMessage: startingAppMessage,
      maxLogCount: maxLogCount,
    ),
  );
}
