import '../config_store_service.dart';

class InMemoryBackend implements ConfigStoreBackend {
  final Map<String, dynamic> _data = {};

  @override
  Future<void> initialize() async {}

  @override
  Future<Map<String, dynamic>> getAll() async {
    return Map.from(_data);
  }

  @override
  Future<void> set(String key, dynamic value) async {
    _data[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    _data.remove(key);
  }

  @override
  Future<void> clear() async {
    _data.clear();
  }
}
