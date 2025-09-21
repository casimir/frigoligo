import '../../../../config/logging.dart';
import 'database/database.dart';

class LocalStorageService {
  LocalStorageService();

  final DB _db = DB();
  DB get db => _db;

  Future<int> appendLog(LogRecord record) =>
      _db.appLogsDao.appendRecord(record);
}
