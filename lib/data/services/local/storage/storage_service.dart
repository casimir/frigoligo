import 'package:logging/logging.dart';

import 'database/database.dart';

class LocalStorageService {
  LocalStorageService();

  final DB _db = DB();

  @Deprecated('this getter will be deleted at some point')
  DB get db => _db;

  int get dbVersion => _db.schemaVersion;

  Future<int> appendLog(LogRecord record) =>
      _db.appLogsDao.appendRecord(record);
}
