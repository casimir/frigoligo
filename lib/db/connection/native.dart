import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

Future<(String, String)> getDBPath(bool devmode) async {
  final supportDir = await getApplicationSupportDirectory();
  final dir = '${supportDir.path}/offline${devmode ? '-dev' : ''}';
  return (dir, 'data');
}

QueryExecutor openConnection() {
  // TODO delete old db files
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
