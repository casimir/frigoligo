import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../config/dependencies.dart';
import '../data/services/local/storage/config_store_service.dart';
import '../domain/sync/remote_actions.dart';
import '../providers/save_article.dart';
import '../providers/settings.dart';
import '../src/generated/i18n/app_localizations.dart';

class SaveService {
  static const _channel = MethodChannel('net.casimir-lab.frigoligo/save');

  static final _log = Logger('SaveService');
  static late ProviderContainer _providers;

  static void setup() {
    _providers = ProviderContainer();
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'debugHello':
          return 'Hello from Flutter!';
        case 'saveArticle':
          return await _handleSaveArticle(call.arguments);
        default:
          return MissingPluginException('not implemented');
      }
    });
  }

  static Future<void> debugHello() async {
    final message = await _channel.invokeMethod<String>('hello');
    _log.info(message);
  }

  static Future<int?> _handleSaveArticle(String url) async {
    switch (await saveArticle(_providers, url)) {
      case SASPostponed():
        return null;
      case SASSuccess(articleId: final articleId):
        return articleId;
      case SASError(e: final e):
        _log.severe('failed to save URL: $url', e);
        throw _localizedError(e);
      case SASErrorDubiousUrl(parsed: final uri):
        _log.severe('failed to save URL: $url: malformed URI: $uri');
        final l = _localizations();
        throw Exception(l.save_malformedUrlError(uri.toString()));
      default:
        throw Exception('unreachable branch');
    }
  }

  static Exception _localizedError(Object e) {
    final l = _localizations();
    if (e is LocalModeError) {
      return Exception(l.save_localModeError);
    }
    return Exception(e.toString());
  }

  static AppLocalizations _localizations() {
    // TODO not the cleanest way to get the current language with correct DI
    final language = UniversalPreferences.get(Sk.language.key) as Language?;
    final locale =
        language?.locale ?? WidgetsBinding.instance.platformDispatcher.locale;
    return lookupAppLocalizations(locale);
  }
}
