import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import '../constants.dart';

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

class UniversalPreferences {
  static Map<String, dynamic>? _cache;
  static SharedPreferences? _prefs;

  static Future<void> resync() async {
    if (UniversalPlatform.isIOS) {
      await SharedPreferenceAppGroup.setAppGroup(appGroupId);
      _cache = await SharedPreferenceAppGroup.getAll();
    } else {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  static Future<void> setBool(String key, bool value) {
    if (UniversalPlatform.isIOS) {
      _cache![key] = value;
      return SharedPreferenceAppGroup.setBool(key, value);
    } else {
      return _prefs!.setBool(key, value);
    }
  }

  static Future<void> setDouble(String key, double value) {
    if (UniversalPlatform.isIOS) {
      _cache![key] = value;
      return SharedPreferenceAppGroup.setDouble(key, value);
    } else {
      return _prefs!.setDouble(key, value);
    }
  }

  static Future<void> setInt(String key, int value) {
    if (UniversalPlatform.isIOS) {
      _cache![key] = value;
      return SharedPreferenceAppGroup.setInt(key, value);
    } else {
      return _prefs!.setInt(key, value);
    }
  }

  static Future<void> setString(String key, String value) {
    if (UniversalPlatform.isIOS) {
      _cache![key] = value;
      return SharedPreferenceAppGroup.setString(key, value);
    } else {
      return _prefs!.setString(key, value);
    }
  }

  static dynamic get(String key) =>
      UniversalPlatform.isIOS ? _cache![key] : _prefs!.get(key);

  static int? getInt(String key) => get(key) as int?;

  static String? getString(String key) => get(key) as String?;

  static Future<void> remove(String key) {
    if (UniversalPlatform.isIOS) {
      _cache!.remove(key);
      return SharedPreferenceAppGroup.remove(key);
    } else {
      return _prefs!.remove(key);
    }
  }

  static Future<void> clear() {
    if (UniversalPlatform.isIOS) {
      _cache!.clear();
      return SharedPreferenceAppGroup.removeAll();
    } else {
      return _prefs!.clear();
    }
  }
}

@riverpod
class Settings extends _$Settings {
  // Target version for the settings. By convention this is the buildnumber where
  // the migration has been introduced.
  static const latestVersion = 39;

  static const _versionKey = '_version';

  static Language? initialLocaleOverride;
  static String? namespace = kDebugMode ? 'debug' : null;

  static Future<void> init() async {
    await UniversalPreferences.resync();
  }

  Settings() {
    _migrateVersion().then((_) {
      if (initialLocaleOverride != null) {
        _log.info('initial locale override: $initialLocaleOverride');
        set(Sk.language, initialLocaleOverride);
        initialLocaleOverride = null;
      }
    });
  }

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
        return UniversalPreferences.get(key) ?? skey.initial;
      default:
        final raw = UniversalPreferences.getString(key);
        if (raw == null) return skey.initial;
        final codec = skey.codec;
        return codec != null ? codec.decode(raw) : jsonDecode(raw);
    }
  }

  Future<void> set(Sk skey, dynamic value) async {
    _log.info('updating $skey to $value');
    await _setValue(skey, value);
    ref.invalidateSelf();
  }

  Future<void> _setValue(Sk skey, dynamic value) {
    final key = _k(skey.key);
    switch (value) {
      case bool b:
        return UniversalPreferences.setBool(key, b);
      case double d:
        return UniversalPreferences.setDouble(key, d);
      case int i:
        return UniversalPreferences.setInt(key, i);
      case String s:
        return UniversalPreferences.setString(key, s);
      default:
        final raw = skey.codec?.encode(value) ?? jsonEncode(value);
        return UniversalPreferences.setString(key, raw);
    }
  }

  Future<void> clear() async {
    await UniversalPreferences.clear();
    ref.invalidateSelf();
  }

  Future<void> unset(Sk skey) async {
    await UniversalPreferences.remove(_k(skey.key));
    ref.invalidateSelf();
  }

  Future<void> _migrateVersion() async {
    final oldVersion = UniversalPreferences.getInt(_k(_versionKey)) ?? 0;
    if (oldVersion == latestVersion) return;

    var migrated = false;

    if (oldVersion < 37) {
      int? langIndex;
      try {
        langIndex = UniversalPreferences.getInt(_k(Sk.language.key));
      } catch (_) {}
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
          await UniversalPreferences.remove(_k(Sk.language.key));
        }
        migrated = true;
      }

      final themeIndex = UniversalPreferences.getInt(_k(Sk.themeMode.key));
      if (themeIndex != null) {
        await _setValue(Sk.themeMode, ThemeMode.values[themeIndex]);
        migrated = true;
      }
    }
    if (oldVersion < 39 && UniversalPlatform.isIOS) {
      await UniversalPreferences.resync();
      final prefs = await SharedPreferences.getInstance();
      for (final key in prefs.getKeys()) {
        final value = prefs.get(key);
        if (value == null) continue;
        switch (value) {
          case bool b:
            await UniversalPreferences.setBool(key, b);
          case double d:
            await UniversalPreferences.setDouble(key, d);
          case int i:
            await UniversalPreferences.setInt(key, i);
          case String s:
            await UniversalPreferences.setString(key, s);
          default:
            _log.warning(
                'failed to migrate value: ${value.runtimeType}: $value');
        }
      }
      migrated = true;
    }

    if (migrated) {
      _log.info('migrated settings from $oldVersion to $latestVersion');
      await UniversalPreferences.setInt(_k(_versionKey), latestVersion);
      ref.invalidateSelf();
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
// Languages with a translation completeness under 75% are disabled (commented).
// See https://www.omniglot.com/language/names.htm for native names.
enum Language {
  system(null, ''),
  de(Locale('de'), 'Deutsch'),
  en(Locale('en'), 'English'),
  es(Locale('es'), 'Español'),
  eo(Locale('eo'), 'Esperanto'),
  et(Locale('et'), 'eesti keel'),
  fr(Locale('fr'), 'Français'),
  gl(Locale('gl'), 'Galego'),
  it(Locale('it'), 'Italiano'),
  nl(Locale('nl'), 'Nederlands'),
  // pt(Locale('pt', 'PT'), 'Português'),
  ptBR(Locale('pt', 'BR'), 'Português (Brasil)'),
  ru(Locale('ru'), 'Русский язык'),
  ta(Locale('ta'), 'தமிழ்'),
  zh(Locale('zh'), '中文'),
  zhHant(Locale('zh', 'Hant'), '漢文'),
  ;

  const Language(this.locale, this.nativeName);

  final Locale? locale;
  final String nativeName;
}
