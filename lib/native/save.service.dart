import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../providers/save_article.dart';

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
        return null;
      case SASErrorDubiousUrl(parsed: final uri):
        _log.severe('failed to save URL: $url: malformed URI: $uri');
        return null;
      default:
        throw Exception('unreachable branch');
    }
  }
}
