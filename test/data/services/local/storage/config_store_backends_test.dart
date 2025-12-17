import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/data/services/local/storage/config_store_backends/in_memory_backend.dart';
import 'package:frigoligo/data/services/local/storage/config_store_backends/shared_preferences_backend.dart';
import 'package:frigoligo/data/services/local/storage/config_store_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('InMemoryBackend', () {
    runConfigStoreBackendContractTests(() => InMemoryBackend());
  });

  group('SharedPreferencesBackend', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    runConfigStoreBackendContractTests(() {
      SharedPreferences.setMockInitialValues({});
      return SharedPreferencesBackend('test.app.group');
    });
  });
}

void runConfigStoreBackendContractTests(
  ConfigStoreBackend Function() createBackend,
) {
  late ConfigStoreBackend backend;

  setUp(() async {
    backend = createBackend();
    await backend.initialize();
  });

  test('getAll returns empty map initially', () async {
    final result = await backend.getAll();
    expect(result, isEmpty);
  });

  test('set and getAll stores value', () async {
    await backend.set('key1', 'value1');

    final result = await backend.getAll();
    expect(result, {'key1': 'value1'});
  });

  test('set multiple values with different types', () async {
    await backend.set('key1', 'value1');
    await backend.set('key2', 42);
    await backend.set('key3', true);
    await backend.set('key4', 3.14);

    final result = await backend.getAll();
    expect(
      result,
      {'key1': 'value1', 'key2': 42, 'key3': true, 'key4': 3.14},
    );
  });

  test('set overwrites existing value', () async {
    await backend.set('key1', 'value1');
    await backend.set('key1', 'value2');

    final result = await backend.getAll();
    expect(result, {'key1': 'value2'});
  });

  test('remove deletes key', () async {
    await backend.set('key1', 'value1');
    await backend.set('key2', 'value2');
    await backend.remove('key1');

    final result = await backend.getAll();
    expect(result, {'key2': 'value2'});
  });

  test('remove non-existent key does not throw', () async {
    await backend.set('key1', 'value1');

    await backend.remove('non_existent');

    final result = await backend.getAll();
    expect(result, {'key1': 'value1'});
  });

  test('clear removes all keys', () async {
    await backend.set('key1', 'value1');
    await backend.set('key2', 'value2');
    await backend.set('key3', 'value3');

    await backend.clear();

    final result = await backend.getAll();
    expect(result, isEmpty);
  });

  test('supports List<String> values', () async {
    await backend.set('key', ['item1', 'item2', 'item3']);

    final result = await backend.getAll();
    expect(result['key'], ['item1', 'item2', 'item3']);
  });
}
