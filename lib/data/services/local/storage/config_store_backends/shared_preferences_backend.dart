import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import '../config_store_service.dart';

class SharedPreferencesBackend implements ConfigStoreBackend {
  SharedPreferencesBackend(this.appGroup);

  final String appGroup;
  SharedPreferences? _prefs;

  bool get _useAppGroup => UniversalPlatform.isIOS;

  @override
  Future<void> initialize() async {
    if (_useAppGroup) {
      await SharedPreferenceAppGroup.setAppGroup(appGroup);
    } else {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  @override
  Future<Map<String, dynamic>> getAll() async {
    if (_useAppGroup) {
      return await SharedPreferenceAppGroup.getAll();
    } else {
      await _prefs!.reload();
      final data = <String, dynamic>{};
      for (final key in _prefs!.getKeys()) {
        data[key] = _prefs!.get(key);
      }
      return data;
    }
  }

  @override
  Future<void> set(String key, dynamic value) async {
    if (_useAppGroup) {
      if (value is String) {
        await SharedPreferenceAppGroup.setString(key, value);
      } else if (value is int) {
        await SharedPreferenceAppGroup.setInt(key, value);
      } else if (value is double) {
        await SharedPreferenceAppGroup.setDouble(key, value);
      } else if (value is bool) {
        await SharedPreferenceAppGroup.setBool(key, value);
      } else if (value is List<String>) {
        await SharedPreferenceAppGroup.setStringList(key, value);
      } else {
        throw ArgumentError('Unsupported type: ${value.runtimeType}');
      }
    } else {
      if (value is String) {
        await _prefs!.setString(key, value);
      } else if (value is int) {
        await _prefs!.setInt(key, value);
      } else if (value is double) {
        await _prefs!.setDouble(key, value);
      } else if (value is bool) {
        await _prefs!.setBool(key, value);
      } else if (value is List<String>) {
        await _prefs!.setStringList(key, value);
      } else {
        throw ArgumentError('Unsupported type: ${value.runtimeType}');
      }
    }
  }

  @override
  Future<void> remove(String key) async {
    if (_useAppGroup) {
      await SharedPreferenceAppGroup.remove(key);
    } else {
      await _prefs!.remove(key);
    }
  }

  @override
  Future<void> clear() async {
    if (_useAppGroup) {
      // SharedPreferenceAppGroup doesn't have a clear method
      final data = await SharedPreferenceAppGroup.getAll();
      for (final key in data.keys) {
        await SharedPreferenceAppGroup.remove(key);
      }
    } else {
      await _prefs!.clear();
    }
  }
}
