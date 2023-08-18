import 'package:flutter/foundation.dart';
import 'package:frigoligo/constants.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'app_log.dart';
import 'article.dart';
import 'article_scroll_position.dart';

typedef DBInstance = Isar;

class DB {
  static Isar? _instance;
  static final List<LogRecord> _earlyLogs = [];

  static Future<void> init(bool devmode) async {
    if (_instance != null) return;

    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      _instance = Isar.open(
        schemas: [AppLogSchema, ArticleSchema, ArticleScrollPositionSchema],
        directory: dir.path,
        name: 'frigoligo${devmode ? '-dev' : ''}',
      );
    } else {
      await Isar.initialize();
      _instance = Isar.open(
        schemas: [AppLogSchema, ArticleSchema, ArticleScrollPositionSchema],
        directory: Isar.sqliteInMemory,
        engine: IsarEngine.sqlite,
      );
    }
    _prepareAppLogs();
  }

  static bool get isReady => _instance != null;

  static Isar get() {
    assert(_instance != null);
    return _instance!;
  }

  static Future<void> clear() async {
    final db = get();
    await db.writeAsync((db) => db.clear());
  }

  static Future<void> _prepareAppLogs() async {
    for (final record in _earlyLogs) {
      await appendLog(record);
    }
    _earlyLogs.clear();

    final db = get();
    // FIXME this is way to brutal and clunky at the same time
    if (db.appLogs.count() > logCountResetThreshold) {
      db.write((db) => db.appLogs.clear());
    }
  }

  static Future<void> appendLog(LogRecord record) async {
    if (!isReady) {
      _earlyLogs.add(record);
      return;
    }
    final db = get();
    await db.writeAsync((db) => db.appLogs.put(AppLog.fromLogRecord(record)));
  }
}
