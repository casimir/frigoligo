import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ios/settings_syncer.dart';

class SettingsProvider extends ChangeNotifier {
  static late SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
    if (Platform.isIOS) {
      await SettingsSyncer.init();
    }
  }

  SettingsProvider({this.namespace}) {
    if (Platform.isIOS) {
      _syncer = SettingsSyncer(this);
    }
  }

  final String? namespace;
  SettingsSyncer? _syncer;

  String _k(String key) => namespace != null ? '\$$namespace.$key' : key;

  operator [](Sk skey) => _getValue(skey);
  operator []=(Sk skey, dynamic value) {
    _setValue(skey, value);
    _syncer?.onChange(skey, value);
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

    switch (skey.initial) {
      case bool _:
      case double _:
      case int _:
      case String _:
        return _prefs.get(key) ?? skey.initial;
      case List<String> _:
        return _prefs.getStringList(key);
      default:
        final raw = _prefs.getString(key);
        if (raw == null) return skey.initial;
        return jsonDecode(raw);
    }
  }

  Future<bool> _setValue(Sk skey, dynamic value) {
    final key = _k(skey.key);
    switch (value) {
      case bool b:
        return _prefs.setBool(key, b);
      case double d:
        return _prefs.setDouble(key, d);
      case int i:
        return _prefs.setInt(key, i);
      case String s:
        return _prefs.setString(key, s);
      case List<String> ss:
        return _prefs.setStringList(key, ss);
      default:
        if (value case Enum e) return _prefs.setInt(key, e.index);
        return _prefs.setString(key, jsonEncode(value));
    }
  }

  Future<bool> clear() async {
    final ret = await _prefs.clear();
    _syncer?.onClear();
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
  language('locale', Language.system, Language.values),
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

enum Language {
  system(null),
  english(Locale('en')),
  french(Locale('fr')),
  german(Locale('de'));

  const Language(this.locale);

  final Locale? locale;
}
