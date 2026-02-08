import 'dart:convert';

import 'package:drift/drift.dart';

import 'services/local/storage/database/database.dart';

Future<void> loadSampleArticles(DB db, String jsonContent) async {
  final articles = List<Map<String, dynamic>>.from(jsonDecode(jsonContent));

  await db.transaction(() async {
    for (final a in articles) {
      await db.customInsert(
        'INSERT INTO articles (id, created_at, updated_at, title, domain_name, url, '
        'content, language, reading_time, preview_picture, archived_at, starred_at, tags) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        variables: [
          Variable<int>(a['id'] as int),
          Variable<int>(a['created_at'] as int),
          Variable<int>(a['updated_at'] as int),
          Variable<String>(a['title'] as String),
          _nullable<String>(a['domain_name']),
          Variable<String>(a['url'] as String),
          _nullable<String>(a['content']),
          _nullable<String>(a['language']),
          Variable<int>(a['reading_time'] as int),
          _nullable<String>(a['preview_picture']),
          _nullable<int>(a['archived_at']),
          _nullable<int>(a['starred_at']),
          Variable<String>(a['tags'] as String),
        ],
      );
    }
  });

  await db.customStatement('PRAGMA optimize');
  await db.customStatement('VACUUM');
}

Variable<Object> _nullable<T extends Object>(T? value) =>
    value == null ? const Variable(null) : Variable<T>(value);
