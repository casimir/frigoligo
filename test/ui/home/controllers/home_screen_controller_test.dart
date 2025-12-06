import 'dart:async';

import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/ui/home/controllers/home_screen_controller.dart';
import 'package:test/test.dart';

void main() {
  group('HomeScreenController', () {
    late DB db;
    late HomeScreenController controller;

    setUp(() {
      db = DB(inMemory());
      setupDependencies(withDB: db);
      controller = HomeScreenController(queryRepository: dependencies.get());
    });

    tearDown(() async {
      await dependencies.reset();
      await db.close();
    });

    test(
      'should provide an ItemCounter that reacts to the query changes',
      () async {
        final itemCounter = await controller.getItemCounter();

        expect(itemCounter.value, equals(0));
        expect(itemCounter.getArticleId(0), equals(null));
        expect(itemCounter.toString(), contains(itemCounter.value.toString()));

        final LocalStorageService localStorageService = dependencies.get();
        await localStorageService.articles.update(
          Article(
            id: 1,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            title: '',
            url: '',
            readingTime: 0,
            tags: [],
          ),
        );

        // await for the event propagation
        Completer completer = Completer();
        itemCounter.addListener(() => completer.complete());
        await completer.future;

        expect(itemCounter.value, equals(1));
        expect(itemCounter.getArticleId(0), equals(1));
        expect(itemCounter.toString(), contains(itemCounter.value.toString()));

        // sanity check
        itemCounter.dispose();
      },
    );
  });
}
