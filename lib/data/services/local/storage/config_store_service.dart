import 'dart:async';

abstract class ConfigStoreBackend {
  /// Initialize hook. Garanteed to be called before any other operation.
  Future<void> initialize();

  /// Retrieve all key-value pairs from storage. Typically used during
  /// initialization and reload operations.
  Future<Map<String, dynamic>> getAll();

  /// Set a value in storage.
  Future<void> set(String key, dynamic value);

  /// Remove a key from storage.
  Future<void> remove(String key);

  /// Clear all keys from storage.
  Future<void> clear();
}

class ConfigStoreService {
  ConfigStoreService(this._backend);

  final ConfigStoreBackend _backend;
  final Map<String, dynamic> _cache = {};
  final Map<String, StreamController<dynamic>> _controllers = {};
  bool _initialized = false;

  /// Initialize the store and load all data into memory cache. Must be called
  /// only once, typically at app startup before any other operations.
  Future<void> initialize() async {
    if (_initialized) {
      throw StateError('ConfigStoreService already initialized');
    }

    await _backend.initialize();
    final data = await _backend.getAll();
    _cache.addAll(data);
    _initialized = true;
  }

  void _ensureInitialized() {
    if (!_initialized) {
      throw StateError('initialize() must be called first');
    }
  }

  void _emitChange(String key, dynamic value) {
    if (_controllers.containsKey(key)) {
      _controllers[key]!.add(value);
    }
  }

  /// Reload all data from disk into memory cache. Typically Used when external
  /// processes (e.g. native extensions) may have modified the config outside
  /// app context.
  Future<void> reload() async {
    _ensureInitialized();

    final newData = await _backend.getAll();

    for (final entry in newData.entries) {
      final oldValue = _cache[entry.key];
      final newValue = entry.value;

      if (oldValue != newValue) {
        _cache[entry.key] = newValue;
        _emitChange(entry.key, newValue);
      }
    }

    for (final key in _cache.keys.toList()) {
      if (!newData.containsKey(key)) {
        _cache.remove(key);
        _emitChange(key, null);
      }
    }
  }

  /// Get a value synchronously from cache.
  T? get<T>(String key) {
    _ensureInitialized();
    return _cache[key] as T?;
  }

  /// Watch a key for changes. Emits current value immediately when subscribed,
  /// then emits whenever the value changes via set() or reload().
  Stream<T?> watch<T>(String key) {
    _ensureInitialized();
    final controller = _controllers.putIfAbsent(
      key,
      () => StreamController<dynamic>.broadcast(),
    );

    return Stream<T?>.multi((streamController) {
      streamController.add(_cache[key] as T?);
      final subscription = controller.stream.listen(
        (value) => streamController.add(value as T?),
      );
      streamController.onCancel = () => subscription.cancel();
    });
  }

  /// Set a value. Updates cache immediately and persists to disk.
  Future<void> set<T>(String key, T value) async {
    _ensureInitialized();
    _cache[key] = value;
    _emitChange(key, value);
    await _backend.set(key, value);
  }

  /// Remove a key. Emits null to stream listeners.
  Future<void> remove(String key) async {
    _ensureInitialized();
    _cache.remove(key);
    _emitChange(key, null);
    await _backend.remove(key);
  }

  /// Clear all keys.
  Future<void> clear() async {
    _ensureInitialized();

    for (final key in _cache.keys) {
      _emitChange(key, null);
    }

    _cache.clear();
    await _backend.clear();
  }
}
