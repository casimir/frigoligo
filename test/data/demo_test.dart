import 'dart:convert';
import 'dart:io';

import 'package:frigoligo/data/demo.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:test/test.dart';

void main() {
  test('loadSampleArticles inserts all articles from JSON', () async {
    final db = DB(inMemory());
    final content = File('assets/sample-articles.json').readAsStringSync();
    final expectedCount = (jsonDecode(content) as List).length;

    await loadSampleArticles(db, content);

    final row = await db
        .customSelect('SELECT COUNT(*) AS c FROM articles')
        .getSingle();
    expect(row.read<int>('c'), expectedCount);

    await db.close();
  });
}
