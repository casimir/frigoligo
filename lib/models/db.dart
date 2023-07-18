import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'article.dart';

typedef DBInstance = Isar;

class DB {
  static Isar? _instance;

  static Future<void> init({bool force = false}) async {
    if (_instance == null || force) {
      var dir = await getApplicationDocumentsDirectory();
      _instance = await Isar.open([ArticleSchema], directory: dir.path);
    }
  }

  static Isar get() {
    assert(_instance != null);
    return _instance!;
  }

  static Future<void> clear() {
    var db = get();
    return db.writeTxn(() => db.clear());
  }
}
