import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/domain/sync/remote_actions.dart';
import 'package:frigoligo/server/clients.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

class FakeArticle extends Fake implements Article {}

Article _createTestArticle({
  required int id,
  String? title,
  bool? archived,
  bool? starred,
}) {
  return Article(
    id: id,
    title: title ?? 'Test Article',
    url: 'https://example.com',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    readingTime: 5,
    tags: [],
    archivedAt: archived == true ? DateTime.now() : null,
    starredAt: starred == true ? DateTime.now() : null,
  );
}

void main() {
  late DB db;
  late LocalStorageService storage;
  late MockApiClient apiClient;

  setUpAll(() {
    registerFallbackValue(FakeArticle());
  });

  setUp(() {
    db = DB(inMemory());
    storage = LocalStorageService(db: db);
    apiClient = MockApiClient();
  });

  tearDown(() async {
    await db.close();
  });

  group('RemoteAction', () {
    test('fromParams creates action from type name and params', () {
      final action = RemoteAction.fromParams('noop', {'value': 'test'});

      expect(action, isA<NoopAction>());
      expect((action as NoopAction).value, 'test');
    });

    test('key uses type name and param values', () {
      const action = NoopAction('test-value');
      expect(action.key, 'noop:test-value');
    });

    test('equality is based on key', () {
      const action1 = NoopAction('test');
      const action2 = NoopAction('test');
      const action3 = NoopAction('other');

      expect(action1, action2);
      expect(action1, isNot(action3));
    });

    test('toString includes type and key', () {
      const action = NoopAction('test-value');
      final actionStr = action.toString();

      expect(actionStr.contains(action.runtimeType.toString()), true);
      expect(actionStr.contains(action.value), true);
    });
  });

  group('RefreshArticlesAction', () {
    test('fromParams roundtrip', () {
      const action = RefreshArticlesAction();
      final restored = RefreshArticlesAction.fromParams(action.params);

      expect(restored, isA<RefreshArticlesAction>());
    });

    group('execute', () {
      test('performs full refresh when no last sync', () async {
        const action = RefreshArticlesAction();
        final article = _createTestArticle(id: 1);

        when(
          () => apiClient.listArticles(
            since: any(named: 'since'),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer((_) => Stream.value([article]));

        await action.execute(apiClient, storage, (_) {});

        verify(
          () => apiClient.listArticles(
            since: null,
            onProgress: any(named: 'onProgress'),
          ),
        ).called(1);
        expect(await storage.metadata.getLastSyncTS(), isNotNull);
      });

      test('performs incremental refresh when last sync exists', () async {
        const action = RefreshArticlesAction();
        final lastSync =
            (DateTime.now().millisecondsSinceEpoch / 1000).toInt() - 120;
        await storage.metadata.setLastSyncTS(lastSync);

        when(
          () => apiClient.listOperations(
            since: any(named: 'since'),
            localIds: any(named: 'localIds'),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer((_) async => []);

        await action.execute(apiClient, storage, (_) {});

        verify(
          () => apiClient.listOperations(
            since: any(named: 'since'),
            localIds: any(named: 'localIds'),
            onProgress: any(named: 'onProgress'),
          ),
        ).called(1);
        verifyNever(
          () => apiClient.listArticles(
            since: any(named: 'since'),
            onProgress: any(named: 'onProgress'),
          ),
        );
      });

      test('handles created, updated, and deleted operations', () async {
        const action = RefreshArticlesAction();
        final lastSync =
            (DateTime.now().millisecondsSinceEpoch / 1000).toInt() - 120;
        await storage.metadata.setLastSyncTS(lastSync);

        final operations = [
          ArticleOperation(
            articleId: 1,
            type: ArticleOpType.created,
            performedAt: DateTime.now(),
          ),
          ArticleOperation(
            articleId: 2,
            type: ArticleOpType.updated,
            performedAt: DateTime.now(),
          ),
          ArticleOperation(
            articleId: 3,
            type: ArticleOpType.deleted,
            performedAt: DateTime.now(),
          ),
        ];

        when(
          () => apiClient.listOperations(
            since: any(named: 'since'),
            localIds: any(named: 'localIds'),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer((_) async => operations);
        when(
          () => apiClient.getArticle(1),
        ).thenAnswer((_) async => _createTestArticle(id: 1));
        when(
          () => apiClient.getArticle(2),
        ).thenAnswer((_) async => _createTestArticle(id: 2));

        await action.execute(apiClient, storage, (_) {});

        verify(() => apiClient.getArticle(1)).called(1);
        verify(() => apiClient.getArticle(2)).called(1);
        verifyNever(() => apiClient.getArticle(3));
      });
    });
  });

  group('DeleteArticleAction', () {
    test('fromParams roundtrip', () {
      const action = DeleteArticleAction(123);
      final restored = DeleteArticleAction.fromParams(action.params);

      expect(restored.articleId, action.articleId);
    });

    test('execute deletes article', () async {
      const action = DeleteArticleAction(123);
      when(
        () => apiClient.deleteArticle(any()),
      ).thenAnswer((_) async => ApiActionResult.succeed);

      await action.execute(apiClient, storage, (_) {});

      verify(() => apiClient.deleteArticle(123)).called(1);
    });
  });

  group('EditArticleAction', () {
    test('fromParams roundtrip', () {
      const action = EditArticleAction(
        123,
        archived: true,
        starred: false,
        tags: ['tag1'],
      );
      final restored = EditArticleAction.fromParams(action.params);
      expect(restored.articleId, action.articleId);
      expect(restored.archived, action.archived);
      expect(restored.starred, action.starred);
      expect(restored.tags, action.tags);
    });

    test('fromParams handles null values', () {
      final action = EditArticleAction.fromParams({
        'articleId': 123,
        'archived': null,
        'starred': null,
        'tags': null,
      });
      expect(action.articleId, 123);
      expect(action.archived, isNull);
      expect(action.starred, isNull);
      expect(action.tags, isNull);
    });

    test('execute updates article', () async {
      const action = EditArticleAction(123, archived: true, starred: false);
      final updatedArticle = _createTestArticle(id: 123, archived: true);

      when(
        () => apiClient.updateArticle(
          any(),
          archived: any(named: 'archived'),
          starred: any(named: 'starred'),
          tags: any(named: 'tags'),
        ),
      ).thenAnswer((_) async => updatedArticle);

      await action.execute(apiClient, storage, (_) {});

      verify(
        () => apiClient.updateArticle(
          123,
          archived: true,
          starred: false,
          tags: null,
        ),
      ).called(1);
    });
  });

  group('SaveArticleAction', () {
    test('fromParams roundtrip', () {
      final action = SaveArticleAction(
        Uri.parse('https://example.com'),
        tags: ['tag1'],
      );
      final restored = SaveArticleAction.fromParams(action.params);

      expect(restored.url, action.url);
      expect(restored.tags, action.tags);
    });

    test('execute creates article and returns ID', () async {
      final action = SaveArticleAction(Uri.parse('https://example.com'));
      final savedArticle = _createTestArticle(id: 456);

      when(
        () => apiClient.createArticle(any(), tags: any(named: 'tags')),
      ).thenAnswer((_) async => savedArticle);

      final articleId = await action.execute(apiClient, storage, (_) {});

      expect(articleId, 456);
      verify(
        () => apiClient.createArticle('https://example.com', tags: null),
      ).called(1);
    });
  });

  group('RefetchArticleAction', () {
    test('fromParams roundtrip', () {
      const action = RefetchArticleAction(123);
      final restored = RefetchArticleAction.fromParams(action.params);

      expect(restored.articleId, action.articleId);
    });

    group('execute', () {
      test('returns true on success', () async {
        const action = RefetchArticleAction(123);
        final refetchedArticle = _createTestArticle(id: 123);

        when(
          () => apiClient.recrawlArticle(any()),
        ).thenAnswer((_) async => ApiActionResult.succeed);
        when(
          () => apiClient.getArticle(any()),
        ).thenAnswer((_) async => refetchedArticle);

        final result = await action.execute(apiClient, storage, (_) {});

        expect(result, true);
        verify(() => apiClient.recrawlArticle(123)).called(1);
        verify(() => apiClient.getArticle(123)).called(1);
      });

      test('returns false on error', () async {
        const action = RefetchArticleAction(123);

        when(
          () => apiClient.recrawlArticle(any()),
        ).thenThrow(Exception('API error'));

        final result = await action.execute(apiClient, storage, (_) {});

        expect(result, false);
        verifyNever(() => apiClient.getArticle(any()));
      });
    });
  });
}
