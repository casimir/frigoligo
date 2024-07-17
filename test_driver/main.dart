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

  switch (Environment.getString('locale')?.split('-').first) {
    case 'de':
      Settings.initialLocaleOverride = Language.de;
    case 'en':
      Settings.initialLocaleOverride = Language.en;
    case 'fr':
      Settings.initialLocaleOverride = Language.fr;
    case 'zh':
      Settings.initialLocaleOverride = Language.zh;
    default:
      throw 'unhandled locale';
  }

  WidgetsApp.debugAllowBannerOverride = false;
  app.main();
}
