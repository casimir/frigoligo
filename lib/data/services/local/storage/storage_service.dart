import 'database/database.dart';

class LocalStorageService {
  LocalStorageService({required DB db}) : _db = db;

  final DB _db;

  @Deprecated('this getter will be deleted at some point')
  DB get db => _db;

  int get dbVersion => _db.schemaVersion;
}
