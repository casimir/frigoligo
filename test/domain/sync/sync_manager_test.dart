import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/app_info.dart';
import 'package:frigoligo/data/services/local/storage/config_store_service.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/data/services/platform/appbadge_service.dart';
import 'package:frigoligo/domain/models/server_session.dart';
import 'package:frigoligo/domain/repositories.dart';
import 'package:frigoligo/domain/sync/sync_manager.dart';
import 'package:frigoligo/server/clients.dart';
import 'package:mocktail/mocktail.dart';

class MockServerSessionRepository extends Mock
    implements ServerSessionRepository {}

class MockConfigStoreService extends Mock implements ConfigStoreService {}

class MockAppBadgeService extends Mock implements AppBadgeService {}

class FakeRemoteAction extends Fake implements RemoteAction {}

void main() {
  late DB db;
  late LocalStorageService storage;
  late MockServerSessionRepository sessionRepo;
  late MockConfigStoreService configStore;
  late MockAppBadgeService appBadge;
  late SyncManager syncManager;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock package_info_plus
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('dev.fluttercommunity.plus/package_info'),
          (MethodCall methodCall) async {
            if (methodCall.method == 'getAll') {
              return <String, dynamic>{
                'appName': 'Test App',
                'packageName': 'com.test.app',
                'version': '1.0.0',
                'buildNumber': '1',
              };
            }
            return null;
          },
        );

    await AppInfo.init();
    registerFallbackValue(FakeRemoteAction());
  });

  setUp(() {
    db = DB(inMemory());
    storage = LocalStorageService(db: db);
    sessionRepo = MockServerSessionRepository();
    configStore = MockConfigStoreService();
    appBadge = MockAppBadgeService();

    final session = ServerSession(
      ServerType.freon,
      freon: TokenBearerCredentials(Uri.parse('https://test.com'), 'token'),
    );
    when(() => sessionRepo.getSession()).thenReturn(session);
    when(() => configStore.get<bool>(any())).thenReturn(false);
    when(() => appBadge.isSupported()).thenAnswer((_) async => false);
    when(() => appBadge.update(any())).thenAnswer((_) async {});

    syncManager = SyncManager(
      localStorageService: storage,
      serverSessionRepository: sessionRepo,
      configStoreService: configStore,
      appBadgeService: appBadge,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('initialization', () {
    test(
      'should initialize with default state and support singleton pattern',
      () {
        expect(syncManager.state.isWorking, false);
        expect(syncManager.state.progressValue, null);
        expect(syncManager.state.lastError, null);
        expect(syncManager.state.pendingCount, 0);

        SyncManager.init(
          localStorageService: storage,
          serverSessionRepository: sessionRepo,
          configStoreService: configStore,
          appBadgeService: appBadge,
        );
        expect(SyncManager.instance, isA<SyncManager>());
      },
    );
  });

  group('listener management', () {
    test('should add and remove listeners', () async {
      final states = <SyncState>[];
      void listener(SyncState state) => states.add(state);

      syncManager.addListener(listener);
      await syncManager.addAction(const DeleteArticleAction(1));
      expect(states.length, greaterThan(0));
      expect(states.last.pendingCount, 1);

      states.clear();
      syncManager.removeListener(listener);
      await syncManager.addAction(const DeleteArticleAction(2));
      expect(states, isEmpty);
    });
  });

  group('action queue', () {
    test('should add actions with deduplication and track count', () async {
      const action1 = DeleteArticleAction(1);
      const action2 = DeleteArticleAction(2);

      expect(await syncManager.getPendingCount(), 0);

      await syncManager.addAction(action1);
      expect(await syncManager.getPendingCount(), 1);

      // Duplicate should not be added
      await syncManager.addAction(action1);
      expect(await syncManager.getPendingCount(), 1);

      await syncManager.addAction(action2);
      expect(await syncManager.getPendingCount(), 2);
    });
  });

  group('sync execution', () {
    test('should execute full sync lifecycle', () async {
      await syncManager.addAction(const NoopAction('test1'));
      await syncManager.addAction(const NoopAction('test2'));
      await syncManager.addAction(const NoopAction('test3'));

      final states = <SyncState>[];
      final progressValues = <double?>[];
      final counts = <int>[];

      syncManager.addListener((state) {
        states.add(state);
        progressValues.add(state.progressValue);
        counts.add(state.pendingCount);
      });

      // Test without final refresh
      final result1 = await syncManager.synchronize(withFinalRefresh: false);

      // isWorking transitions: false -> true -> false
      expect(states.any((s) => s.isWorking), true);
      expect(states.last.isWorking, false);

      expect(progressValues.any((p) => p != null && p > 0), true);
      expect(states.last.progressValue, null);

      // PendingCount decreases: 3 -> 0
      expect(counts.first, 3);
      expect(counts.last, 0);

      expect(syncManager.state.isWorking, false);
      expect(syncManager.state.lastError, null);
      expect(await syncManager.getPendingCount(), 0);

      expect(result1, isA<Map<String, dynamic>>());
      expect(result1.length, 3);

      // Test with final refresh
      await syncManager.addAction(const NoopAction('test4'));
      final result2 = await syncManager.synchronize(withFinalRefresh: true);
      expect(result2, isA<Map<String, dynamic>>());
      expect(await syncManager.getPendingCount(), 0);
    });

    test(
      'should update app badge based on configuration when supported',
      () async {
        when(() => appBadge.isSupported()).thenAnswer((_) async => true);

        // When enabled
        when(() => configStore.get<bool>(any())).thenReturn(true);
        await syncManager.addAction(const NoopAction('test1'));
        await syncManager.synchronize(withFinalRefresh: false);
        verify(() => appBadge.update(any())).called(1);

        // When disabled
        when(() => configStore.get<bool>(any())).thenReturn(false);
        await syncManager.addAction(const NoopAction('test2'));
        await syncManager.synchronize(withFinalRefresh: false);
        verifyNever(() => appBadge.update(any()));
      },
    );

    test('should not update app badge when unsupported', () async {
      when(() => appBadge.isSupported()).thenAnswer((_) async => false);
      when(() => configStore.get<bool>(any())).thenReturn(true);
      await syncManager.addAction(const NoopAction('test1'));
      await syncManager.synchronize(withFinalRefresh: false);
      verifyNever(() => appBadge.update(any()));
    });
  });

  group('error handling', () {
    test('should handle different error types correctly', () async {
      // ServerError should be captured
      await syncManager.addAction(
        NoopAction.error(const ServerError('test error')),
      );
      await syncManager.synchronize(withFinalRefresh: false);
      expect(syncManager.state.lastError, isA<ServerError>());
      expect(syncManager.state.lastError.toString(), contains('test error'));
      expect(syncManager.state.isWorking, false);
      await storage.remoteActions.clear();

      // ServerError with ClientException source should NOT be captured
      await syncManager.addAction(
        const NoopAction('ERROR:ClientException:network error'),
      );
      await syncManager.synchronize(withFinalRefresh: false);
      expect(syncManager.state.lastError, null);
      expect(syncManager.state.isWorking, false);
      await storage.remoteActions.clear();

      // Generic Exception should be captured
      await syncManager.addAction(NoopAction.error(Exception('generic error')));
      await syncManager.synchronize(withFinalRefresh: false);
      expect(syncManager.state.lastError, isA<Exception>());
      expect(syncManager.state.isWorking, false);
    });

    test(
      'should persist failed actions and clear errors appropriately',
      () async {
        // Failed action should remain in queue for retry
        await syncManager.addAction(NoopAction.error(Exception('test error')));
        await syncManager.synchronize(withFinalRefresh: false);
        expect(await syncManager.getPendingCount(), 1);
        expect(syncManager.state.lastError, isA<Exception>());

        // Remove the failed action from DB directly
        await storage.remoteActions.clear();

        // Next sync with empty queue should clear error
        await syncManager.synchronize(withFinalRefresh: false);
        expect(syncManager.state.lastError, null);
        expect(await syncManager.getPendingCount(), 0);
      },
    );
  });

  group('SyncState', () {
    test('copyWith should update selectively', () {
      const original = SyncState(
        isWorking: true,
        progressValue: 0.5,
        lastError: null,
        pendingCount: 3,
      );

      // Update single field, preserve others
      final partial = original.copyWith(isWorking: false);
      expect(partial.isWorking, false);
      expect(partial.progressValue, 0.5);
      expect(partial.lastError, null);
      expect(partial.pendingCount, 3);

      // Update all fields
      final error = Exception('test');
      final complete = original.copyWith(
        isWorking: false,
        progressValue: 0.7,
        lastError: error,
        pendingCount: 5,
      );
      expect(complete.isWorking, false);
      expect(complete.progressValue, 0.7);
      expect(complete.lastError, error);
      expect(complete.pendingCount, 5);
    });
  });

  group('throttling', () {
    test('should allow sync when no previous sync timestamp exists', () async {
      await syncManager.addAction(const NoopAction('test'));

      final result = await syncManager.throttledSynchronize(
        withFinalRefresh: false,
      );

      expect(result.isNotEmpty, true);
      expect(await syncManager.getPendingCount(), 0);
    });

    test('should throttle sync when last sync was recent', () async {
      final recentTimestamp =
          DateTime.now().millisecondsSinceEpoch ~/ 1000 - 60;
      await storage.metadata.setLastSyncTS(recentTimestamp);
      await syncManager.addAction(const NoopAction('test'));

      final result = await syncManager.throttledSynchronize(
        withFinalRefresh: false,
      );

      expect(result.isEmpty, true);
      expect(await syncManager.getPendingCount(), 1);
    });

    test('should allow sync when last sync was long ago', () async {
      final epochSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final oldTimestamp = epochSeconds - autoSyncThrottleSeconds - 1;
      await storage.metadata.setLastSyncTS(oldTimestamp);
      await syncManager.addAction(const NoopAction('test'));

      final result = await syncManager.throttledSynchronize(
        withFinalRefresh: false,
      );

      expect(result.isNotEmpty, true);
      expect(await syncManager.getPendingCount(), 0);
    });
  });
}
