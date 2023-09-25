import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static late SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SettingsProvider({this.namespace});

  final String? namespace;

  String _k(String key) => namespace != null ? '\$$namespace.$key' : key;

  operator [](Sk skey) => _getValue(skey);
  operator []=(Sk skey, dynamic value) {
    _setValue(skey, value);
    notifyListeners();
  }

  Set<String> get keys => _prefs.getKeys();

  dynamic _getValue(Sk skey) {
    final key = _k(skey.key);
    if (skey.items != null) {
      final index = _prefs.getInt(_k(skey.key));
      if (index == null) return skey.initial;
      return skey.items![index];
    }

    switch (skey.initial.runtimeType) {
      case bool:
      case double:
      case int:
      case String:
        return _prefs.get(key) ?? skey.initial;
      case const (List<String>):
        return _prefs.getStringList(key);
      default:
        final raw = _prefs.getString(key);
        if (raw == null) return skey.initial;
        return jsonDecode(raw);
    }
  }

  Future<bool> _setValue(Sk skey, dynamic value) {
    final key = _k(skey.key);
    switch (value.runtimeType) {
      case bool:
        return _prefs.setBool(key, value as bool);
      case double:
        return _prefs.setDouble(key, value as double);
      case int:
        return _prefs.setInt(key, value as int);
      case String:
        return _prefs.setString(key, value as String);
      case const (List<String>):
        return _prefs.setStringList(key, value as List<String>);
      default:
        if (value is Enum) return _prefs.setInt(key, value.index);
        return _prefs.setString(key, jsonEncode(value));
    }
  }

  Future<bool> clear() async {
    final ret = await _prefs.clear();
    notifyListeners();
    return ret;
  }

  Future<bool> remove(Sk skey) async {
    final ret = await _prefs.remove(_k(skey.key));
    notifyListeners();
    return ret;
  }
}

// Settings Keys
const skThemeMode = 'settings.themeMode';

enum Sk {
  appBadge('appBadge', false),
  lastRefresh('lastRefresh', -1),
  selectedArticleId('selectedArticleId', -1),
  tagSaveEnabled('tagSaveEnabled', false),
  tagSaveLabel('tagSaveLabel', 'inbox'),
  themeMode('themeMode', ThemeMode.system, ThemeMode.values);

  const Sk(this._key, this.initial, [this.items]);

  final String _key;
  final Object initial;
  final List<Object>? items;

  String get key => 'settings.$_key';
}
