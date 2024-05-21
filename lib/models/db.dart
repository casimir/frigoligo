import 'dart:io';

import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import '../constants.dart';
import 'app_log.dart';
import 'article.dart';
import 'article_scroll_position.dart';
import 'remote_action.dart';

typedef DBInstance = Isar;

class DB {
  static Isar? _instance;
  static final List<LogRecord> _earlyLogs = [];

  static Future<(String, String)> getDBPath(bool devmode) async {
    final supportDir = await getApplicationSupportDirectory();
    final dir = '${supportDir.path}/offline${devmode ? '-dev' : ''}';
    return (dir, 'data');
  }

  static Future<void> init(bool devmode) async {
    if (_instance != null) return;

    await migrateDataLocation(devmode);

    final (dir, name) = await getDBPath(devmode);
    _instance = await Isar.open(
      [
        AppLogSchema,
        ArticleSchema,
        ArticleScrollPositionSchema,
        RemoteActionSchema,
      ],
      directory: dir,
      name: name,
    );
    _prepareAppLogs();
  }

  static bool get isReady => _instance != null;

  static Isar get() {
    assert(_instance != null);
    return _instance!;
  }

  static Future<void> clear() async {
    final db = get();
    await db.writeTxn(() => db.clear());
  }

  static Future<void> _prepareAppLogs() async {
    for (final record in _earlyLogs) {
      await appendLog(record);
    }
    _earlyLogs.clear();

    final db = get();
    // FIXME this is way to brutal and clunky at the same time
    if (await db.appLogs.count() > logCountResetThreshold) {
      await db.writeTxn(() async {
        await db.appLogs.clear();
      });
    }
  }

  static Future<void> appendLog(LogRecord record) async {
    if (!isReady) {
      _earlyLogs.add(record);
      return;
    }
    final db = get();
    await db.writeTxn(() => db.appLogs.put(AppLog.fromLogRecord(record)));
  }
}

/// Migrate data from old locations. It should be deleted after some time.
Future<void> migrateDataLocation(bool devmode) async {
  final (dir, fname) = await DB.getDBPath(devmode);
  final target = '$dir/$fname.isar';

  final docsDir = await getApplicationDocumentsDirectory();
  final migrateTable = {
    // until v1.0.10
    '${docsDir.path}/frigoligo${devmode ? '-dev' : ''}.isar': target,
  };

  for (final it in migrateTable.entries) {
    final src = File(it.key);
    if (await src.exists()) {
      final lastSeparator = it.value.lastIndexOf(Platform.pathSeparator);
      Directory(it.value.substring(0, lastSeparator + 1))
          .createSync(recursive: true);
      await src.copy(it.value);
      await src.delete();

      final lockFile = File('${src.path}.lock');
      if (await lockFile.exists()) {
        await lockFile.delete();
      }
    }
  }
}
