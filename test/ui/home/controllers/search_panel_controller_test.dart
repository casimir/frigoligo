import 'dart:async';

import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/domain/models/query.dart';
import 'package:frigoligo/ui/home/controllers/search_panel_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockQueryRepository extends Mock implements QueryRepository {}

void main() {
  group('SearchPanelController', () {
    late DB db;

    setUp(() {
      db = DB(inMemory());
      setupDependencies(withDB: db);
    });

    tearDown(() async {
      await dependencies.reset();
      await db.close();
    });

    test('should be able to modify the query', () async {
      final QueryRepository queryRepository = dependencies.get();
      final controller = SearchPanelController(
        queryRepository: queryRepository,
      );

      Completer completer = Completer();
      final subscription = queryRepository.queryStream.listen((query) {
        // Depending on the execution timing there will be between 1 and 6 state
        // updates so let's wait for the last one (tags).
        if (query.tags.isNotEmpty) {
          completer.complete();
        }
      });

      controller
        ..setText('test')
        ..setTextMode(SearchTextMode.title)
        ..setState(StateFilter.archived)
        ..setOnlyStarred(true)
        ..setDomains(['test'])
        ..setTags(['test']);

      await completer.future;
      subscription.cancel();

      expect(
        queryRepository.query,
        equals(
          const Query(
            text: 'test',
            textMode: SearchTextMode.title,
            state: StateFilter.archived,
            onlyStarred: true,
            domains: ['test'],
            tags: ['test'],
          ),
        ),
      );
    });
  });
}
