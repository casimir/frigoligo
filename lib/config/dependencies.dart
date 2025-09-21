import 'package:get_it/get_it.dart';

import '../data/repositories/logger_repository.dart';
import '../data/services/local/storage/storage_service.dart';
import '../domain/repositories.dart';

export '../domain/repositories.dart';

final dependencies = GetIt.instance;

void setupDependencies() {
  final d = dependencies;

  d.registerLazySingleton(() => LocalStorageService());

  d.registerLazySingleton(() {
    final LocalStorageService storage = d.get();
    return LoggerRepositoryImpl(storage) as LoggerRepository;
  });
}
