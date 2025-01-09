// ignore_for_file: avoid_print

import 'package:emulators/emulators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:frigoligo/main.dart' as app;
import 'package:frigoligo/providers/settings.dart';

const locales = {
  'de-DE': Language.de,
  'en-US': Language.en,
  'es-ES': Language.es,
  'et': Language.et,
  'fr-FR': Language.fr,
  'ru-RU': Language.ru,
  'ta-IN': Language.ta,
  'zh-Hans': Language.zh,
  'zh-Hant': Language.zhHant,
};

void main() {
  enableFlutterDriverExtension();

  print('device: ${Environment.device}');
  print('config: ${Environment.config}');

  final localeOverride = locales[Environment.getString('locale')];
  assert(localeOverride != null, 'unhandled locale');
  Settings.initialLocaleOverride = localeOverride;

  WidgetsApp.debugAllowBannerOverride = false;
  app.main();
}
