// ignore_for_file: avoid_print

import 'package:emulators/emulators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:frigoligo/main.dart' as app;
import 'package:frigoligo/providers/settings.dart';

void main() {
  enableFlutterDriverExtension();

  print('device: ${Environment.device}');
  print('config: ${Environment.config}');

  switch (Environment.getString('locale')) {
    case 'de-DE':
      Settings.initialLocaleOverride = Language.de;
    case 'en-US':
      Settings.initialLocaleOverride = Language.en;
    case 'es-ES':
      Settings.initialLocaleOverride = Language.es;
    case 'et-EE':
      Settings.initialLocaleOverride = Language.et;
    case 'fr-FR':
      Settings.initialLocaleOverride = Language.fr;
    case 'zh-Hans':
      Settings.initialLocaleOverride = Language.zh;
    case 'zh-Hant':
      Settings.initialLocaleOverride = Language.zhHant;
    default:
      throw 'unhandled locale';
  }

  WidgetsApp.debugAllowBannerOverride = false;
  app.main();
}
