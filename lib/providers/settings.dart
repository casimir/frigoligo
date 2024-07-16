import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import 'ios/settings_syncer.dart';

final _log = Logger('settings');

class SettingsValues extends ChangeNotifier {
  static Language? initialLocaleOverride;
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SettingsValues({this.namespace}) {
    if (UniversalPlatform.isIOS) {
      _syncer = SettingsSyncer(this);
    }

    if (initialLocaleOverride != null) {
      _log.info('initial locale override: $initialLocaleOverride');
      this[Sk.language] = initialLocaleOverride;
      initialLocaleOverride = null;
    }
  }

  final String? namespace;
  SettingsSyncer? _syncer;

  String _k(String key) => namespace != null ? '\$$namespace.$key' : key;

  operator [](Sk skey) => _getValue(skey);
  operator []=(Sk skey, dynamic value) {
    _log.info('updating $skey to $value');
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
enum Sk {
  appBadge('appBadge', false),
  lastRefresh('lastRefresh', -1),
  language('locale', Language.system, Language.values),
  selectedArticleId('selectedArticleId', -1),
  readingSettings('readingSettings', Object()),
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
  system(null, ''),
  // values should be in alphabetical order as they are displayed in the UI
  // FIXME this value is stored using its enum index, so only append for now
  de(Locale('de'), 'Deustch'),
  en(Locale('en'), 'English'),
  fr(Locale('fr'), 'Français'),
  gl(Locale('gl'), 'Galego'),
  ptBR(Locale('pt', 'BR'), 'Português (Brasil)'),
  zh(Locale('zh'), '中文'),
  ;

  const Language(this.locale, this.nativeName);

  final Locale? locale;
  final String nativeName;
}

// TODO rewrite with the decorator syntax
final settingsProvider = ChangeNotifierProvider(
    (ref) => SettingsValues(namespace: kDebugMode ? 'debug' : null));
