import 'dart:convert';
import 'dart:io';

abstract class LocalizationLoader {
  final Map<String, Map<String, dynamic>> _localizations = {};

  String buildLocalePath(String locale);
  String rewriteLocale(String locale) => locale.split('-').first;

  void _loadLocale(String locale) {
    final localePath = buildLocalePath(locale);
    final localeJson = File(localePath).readAsStringSync();
    _localizations[locale] = json.decode(localeJson);
  }

  Map<String, dynamic> _getLocale(String locale) {
    locale = rewriteLocale(locale);
    if (!_localizations.containsKey(locale)) {
      _loadLocale(locale);
    }
    return _localizations[locale]!;
  }

  String getValue(String locale, String key) => _getLocale(locale)[key]!;
}

/// Read from the project's localization files.
class ProjectLocalizationLoader extends LocalizationLoader {
  @override
  String buildLocalePath(String locale) {
    return 'lib/l10n/app_$locale.arb';
  }

  @override
  String rewriteLocale(String locale) {
    final rewrites = {'pt-BR': 'pt_BR', 'zh-Hant': 'zh_Hant'};
    return rewrites[locale] ?? super.rewriteLocale(locale);
  }
}

/// Read from the Flutter Material localization files.
/// Online version: https://github.com/flutter/flutter/tree/master/packages/flutter_localizations/lib/src/l10n
class MaterialLocalizationLoader extends LocalizationLoader {
  String _getFlutterPath() {
    var bin = (Process.runSync('which', ['flutter']).stdout as String).trim();
    try {
      bin = File(bin).resolveSymbolicLinksSync();
    } catch (_) {}
    const suffix = '/bin/flutter';
    final cleaned = bin.substring(0, bin.length - suffix.length);
    return cleaned;
  }

  @override
  String buildLocalePath(String locale) {
    final flutterPath = _getFlutterPath();
    final flutterLocalizationsPath =
        '$flutterPath/packages/flutter_localizations';
    return '$flutterLocalizationsPath/lib/src/l10n/material_$locale.arb';
  }

  @override
  String rewriteLocale(String locale) {
    final rewrites = {
      // flutter logic with zh is unclear
      // 'zh-Hant': 'zh_TW',
    };
    return rewrites[locale] ?? super.rewriteLocale(locale);
  }
}
