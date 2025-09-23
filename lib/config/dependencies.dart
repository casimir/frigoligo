import 'package:get_it/get_it.dart';

import '../data/repositories/logger_repository.dart';
import '../data/services/local/storage/storage_service.dart';
import '../data/services/platform/sharing/sharing_service.dart';
import '../domain/repositories.dart';

export '../domain/repositories.dart';

final dependencies = GetIt.instance;

void setupDependencies() {
  final d = dependencies;

  // data sources

  d.registerLazySingleton(() => LocalStorageService());

  // platorm services

  d.registerLazySingleton(() => SharingService());

  // repositories

  d.registerLazySingleton(() {
    final LocalStorageService storage = d.get();
    return LoggerRepositoryImpl(storage) as LoggerRepository;
  });
}
