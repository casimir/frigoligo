import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import '../app_info.dart';
import 'ios/settings_syncer.dart';

part 'settings.g.dart';

final _log = Logger('settings');

abstract class Codec<T> {
  String encode(T object);
  T decode(String raw);
}

class EnumCodec<T extends Enum> implements Codec<T> {
  const EnumCodec(this.values);

  final List<T> values;

  @override
  String encode(T object) => object.name;

  @override
  T decode(String raw) => values.firstWhere((it) => it.name == raw);
}

@riverpod
class Settings extends _$Settings {
  static const _versionKey = '_version';

  static Language? initialLocaleOverride;
  static String? namespace = kDebugMode ? 'debug' : null;
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Settings() {
    _currentVersion = int.parse(AppInfo.data.buildNumber);
    if (UniversalPlatform.isIOS) {
      _syncer = SettingsSyncer(this);
    }

    _migrateVersion().then((_) {
      if (initialLocaleOverride != null) {
        _log.info('initial locale override: $initialLocaleOverride');
        set(Sk.language, initialLocaleOverride);
        initialLocaleOverride = null;
      }
    });
  }

  late int _currentVersion;
  SettingsSyncer? _syncer;

  @override
  Map<Sk, dynamic> build() {
    return Map.unmodifiable({for (final it in Sk.values) it: get(it)});
  }

  String _k(String key) => namespace != null ? '\$$namespace.$key' : key;

  dynamic get(Sk skey) {
    final key = _k(skey.key);
    switch (skey.initial) {
      case bool _:
      case double _:
      case int _:
      case String _:
        return _prefs.get(key) ?? skey.initial;
      default:
        final raw = _prefs.getString(key);
        if (raw == null) return skey.initial;
        final codec = skey.codec;
        return codec != null ? codec.decode(raw) : jsonDecode(raw);
    }
  }

  Future<void> set(Sk skey, dynamic value) async {
    _log.info('updating $skey to $value');
    await _setValue(skey, value);
    await _syncer?.onChange(skey, value);
    ref.invalidateSelf();
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
      default:
        final raw = skey.codec?.encode(value) ?? jsonEncode(value);
        return _prefs.setString(key, raw);
    }
  }

  Future<bool> clear() async {
    final ret = await _prefs.clear();
    _syncer?.onClear();
    ref.invalidateSelf();
    return ret;
  }

  Future<bool> unset(Sk skey) async {
    final ret = await _prefs.remove(_k(skey.key));
    ref.invalidateSelf();
    return ret;
  }

  Future<void> _migrateVersion() async {
    final oldVersion = _prefs.getInt(_k(_versionKey)) ?? 0;
    if (oldVersion == _currentVersion) return;

    var migrated = false;

    if (oldVersion < 37) {
      final langIndex = _prefs.getInt(_k(Sk.language.key));
      if (langIndex != null) {
        final oldLangOrder = [
          null, // Language.system,
          Language.de,
          Language.en,
          Language.fr,
          Language.gl,
          null, // Language.ptBR,
          Language.zh,
          Language.zhHant,
          null, // Language.ru,
          Language.eo,
        ];
        final lang = oldLangOrder[langIndex];
        if (lang != null) {
          await _setValue(Sk.language, oldLangOrder[langIndex]);
        } else {
          await _prefs.remove(_k(Sk.language.key));
        }
        migrated = true;
      }

      final themeIndex = _prefs.getInt(_k(Sk.themeMode.key));
      if (themeIndex != null) {
        await _setValue(Sk.themeMode, ThemeMode.values[themeIndex]);
        migrated = true;
      }
    }

    if (migrated) {
      _log.info('migrated settings from $oldVersion to $_currentVersion');
      await _prefs.setInt(_k(_versionKey), _currentVersion);
    }
  }
}

// Settings Keys
enum Sk {
  appBadge('appBadge', false),
  language('locale', Language.system, EnumCodec(Language.values)),
  selectedArticleId('selectedArticleId', -1),
  readingSettings('readingSettings', Object()),
  tagSaveEnabled('tagSaveEnabled', false),
  tagSaveLabel('tagSaveLabel', 'inbox'),
  themeMode('themeMode', ThemeMode.system, EnumCodec(ThemeMode.values));

  const Sk(this._key, this.initial, [this.codec]);

  final String _key;
  final Object initial;
  final Codec? codec;

  String get key => 'settings.$_key';
}

// Values are displayed in the UI in this order (alphabetical).
// Languages with a translation completeness under 80% are disabled (commented).
// See https://www.omniglot.com/language/names.htm for native names.
enum Language {
  system(null, ''),
  de(Locale('de'), 'Deutsch'),
  en(Locale('en'), 'English'),
  eo(Locale('eo'), 'Esperanto'),
  fr(Locale('fr'), 'Français'),
  gl(Locale('gl'), 'Galego'),
  // pt(Locale('pt', 'PT'), 'Português'),
  // ptBR(Locale('pt', 'BR'), 'Português (Brasil)'),
  // ru(Locale('ru'), 'Русский язык'),
  zh(Locale('zh'), '中文'),
  zhHant(Locale('zh', 'Hant'), '漢文'),
  ;

  const Language(this.locale, this.nativeName);

  final Locale? locale;
  final String nativeName;
}
