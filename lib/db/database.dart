import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../utils.dart';
import 'converters/containers.dart';
import 'models/app_log.dart';
import 'models/article.dart';
import 'models/remote_action.dart';

part 'database.g.dart';

Future<(String, String)> getDBPath(bool devmode) async {
  final supportDir = await getApplicationSupportDirectory();
  final dir = '${supportDir.path}/offline${devmode ? '-dev' : ''}';
  return (dir, 'data');
}

@DriftDatabase(tables: [
  AppLogs,
  Articles,
  ArticleScrollPositions,
  RemoteActions,
])
class DB extends _$DB {
  DB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> appendLog(LogRecord record) {
    return into(appLogs).insert(AppLogsCompanion.insert(
      time: record.time,
      level: record.level.name,
      loggerName: record.loggerName,
      message: record.message,
      error: Value.absentIfNull(record.error?.toString()),
      stackTrace: Value.absentIfNull(record.stackTrace?.toString()),
      logline: loglineFromRecord(record),
    ));
  }

  Future<void> clear({bool keepPositions = false}) {
    return transaction(() async {
      await articles.deleteAll();
      if (!keepPositions) await articleScrollPositions.deleteAll();
      await remoteActions.deleteAll();
    });
  }

  static DB? _instance;
  static DB get() {
    _instance ??= DB();
    return _instance!;
  }
}

QueryExecutor _openConnection() {
  // TODO delete old db files
  // TODO handle web https://drift.simonbinder.eu/web/
  return LazyDatabase(() async {
    // make sqlite use a sandboxed temp directory
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    final (dir, name) = await getDBPath(kDebugMode);
    final dbFile = File('$dir/$name.sqlite');
    if (kDebugMode) {
      print('DEBUG: database path: "${dbFile.path}"');
    }
    return NativeDatabase.createInBackground(dbFile);
  });
}
