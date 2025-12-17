import 'package:flutter_test/flutter_test.dart';

import 'package:frigoligo/data/services/local/storage/config_store_backends/in_memory_backend.dart';
import 'package:frigoligo/data/services/local/storage/config_store_service.dart';

void main() {
  group('ConfigStoreService', () {
    late ConfigStoreService service;
    late InMemoryBackend backend;

    setUp(() {
      backend = InMemoryBackend();
      service = ConfigStoreService(backend);
    });

    group('initialization', () {
      test('throws StateError when initialized twice', () async {
        await service.initialize();

        expect(() => service.initialize(), throwsA(isA<StateError>()));
      });

      test('loads existing backend data into cache', () async {
        await backend.initialize();
        await backend.set('key1', 'value1');
        await backend.set('key2', 42);

        await service.initialize();

        expect(service.get('key1'), 'value1');
        expect(service.get('key2'), 42);
      });
    });

    group('requires initialization', () {
      test('throws StateError when not initialized', () {
        expect(() => service.get('key'), throwsA(isA<StateError>()));
        expect(() => service.set('key', 'value'), throwsA(isA<StateError>()));
        expect(() => service.watch('key'), throwsA(isA<StateError>()));
      });
    });

    group('set', () {
      setUp(() async {
        await service.initialize();
      });

      test('updates cache and persists to backend', () async {
        await service.set('key', 'value');

        expect(service.get('key'), 'value');

        final backendData = await backend.getAll();
        expect(backendData['key'], 'value');
      });

      test('overwrites existing value', () async {
        await service.set('key', 'value1');
        await service.set('key', 'value2');

        expect(service.get('key'), 'value2');
      });
    });

    group('remove', () {
      setUp(() async {
        await service.initialize();
      });

      test('removes from cache and backend', () async {
        await service.set('key', 'value');
        await service.remove('key');

        expect(service.get('key'), null);

        final backendData = await backend.getAll();
        expect(backendData.containsKey('key'), false);
      });
    });

    group('clear', () {
      setUp(() async {
        await service.initialize();
      });

      test('clears cache and backend', () async {
        await service.set('key1', 'value1');
        await service.set('key2', 'value2');

        await service.clear();

        expect(service.get('key1'), null);
        expect(service.get('key2'), null);

        final backendData = await backend.getAll();
        expect(backendData, isEmpty);
      });
    });

    group('watch', () {
      setUp(() async {
        await service.initialize();
      });

      test('emits new value on set', () async {
        final values = <String?>[];
        final subscription = service.watch<String>('key').listen(values.add);

        await pumpEventQueue();
        await service.set('key', 'value1');
        await pumpEventQueue();
        await service.set('key', 'value2');
        await pumpEventQueue();

        await subscription.cancel();

        expect(values, [null, 'value1', 'value2']);
      });

      test('emits null on remove', () async {
        await service.set('key', 'value');

        final values = <String?>[];
        final subscription = service.watch<String>('key').listen(values.add);

        await pumpEventQueue();
        await service.remove('key');
        await pumpEventQueue();

        await subscription.cancel();

        expect(values, ['value', null]);
      });

      test('multiple watchers receive updates', () async {
        final values1 = <String?>[];
        final values2 = <String?>[];

        final subscription1 = service.watch<String>('key').listen(values1.add);
        final subscription2 = service.watch<String>('key').listen(values2.add);

        await pumpEventQueue();
        await service.set('key', 'value');
        await pumpEventQueue();

        await subscription1.cancel();
        await subscription2.cancel();

        expect(values1, [null, 'value']);
        expect(values2, [null, 'value']);
      });
    });

    group('reload', () {
      setUp(() async {
        await service.initialize();
      });

      test('updates cache with backend changes', () async {
        await service.set('key', 'value1');

        await backend.set('key', 'value2');

        await service.reload();

        expect(service.get('key'), 'value2');
      });

      test('adds new keys from backend', () async {
        await backend.set('new_key', 'new_value');

        await service.reload();

        expect(service.get('new_key'), 'new_value');
      });

      test('removes keys deleted from backend', () async {
        await service.set('key', 'value');

        await backend.remove('key');

        await service.reload();

        expect(service.get('key'), null);
      });

      test('emits changes to watchers on modified values', () async {
        await service.set('key', 'value1');

        final values = <String?>[];
        final subscription = service.watch<String>('key').listen(values.add);

        await pumpEventQueue();
        await backend.set('key', 'value2');
        await service.reload();
        await pumpEventQueue();

        await subscription.cancel();

        expect(values, ['value1', 'value2']);
      });

      test('emits null to watchers on removed keys', () async {
        await service.set('key', 'value');

        final values = <String?>[];
        final subscription = service.watch<String>('key').listen(values.add);

        await pumpEventQueue();
        await backend.remove('key');
        await service.reload();
        await pumpEventQueue();

        await subscription.cancel();

        expect(values, ['value', null]);
      });
    });
  });
}
