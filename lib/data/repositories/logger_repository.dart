import 'package:logging/logging.dart';

import '../../domain/repositories.dart';
import '../services/local/storage/storage_service.dart';

class LoggerRepositoryImpl extends LoggerRepository {
  LoggerRepositoryImpl(this._storage);

  final LocalStorageService _storage;

  @override
  Future<int> appendLog(LogRecord record) {
    return _storage.appendLog(record);
  }
}
