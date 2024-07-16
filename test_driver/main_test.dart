import 'dart:async';

import 'package:emulators/emulators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:frigoligo/widget_keys.dart';
import 'package:test/test.dart';

// this is obviously not versioned
import 'test_credentials.local.dart';

const captureDebug = false;

const androidLocaleRewrite = {
  'zh-Hans': 'zh-CN',
};

Future<void> main() async {
  final locale = Environment.getString('locale')!;
  final darkModeLabel = switch (locale.split('-').first) {
    'de' => 'Dunkel',
    'en' => 'Dark',
    'fr' => 'Sombre',
    'zh' => '深色',
    _ => throw UnimplementedError('dark mode not supported for $locale')
  };
  // Material localizations: https://github.com/flutter/flutter/tree/master/packages/flutter_localizations/lib/src/l10n
  final backTooltip = switch (locale.split('-').first) {
    'de' => 'Zurück',
    'en' => 'Back',
    'fr' => 'Retour',
    'zh' => '返回',
    _ => throw UnimplementedError('back tooltip not supported for $locale')
  };
  final okCancelLabel = switch (locale.split('-').first) {
    'de' => 'OK',
    'en' => 'OK',
    'fr' => 'OK',
    'zh' => '确定',
    _ => throw UnimplementedError('ok/cancel label not supported for $locale')
  };

  final deviceName = Environment.getString('deviceName')!;
  final deviceType = Environment.getString('deviceType')!;
  final deviceIsAndroid = deviceName.startsWith('android_');

  final driver = await FlutterDriver.connect();
  final emulators = await Emulators.build();

  final androidImageDirectory =
      deviceType == 'phone' ? 'phoneScreenshots' : 'tenInchScreenshots';
  final androidLocale = androidLocaleRewrite[locale] ?? locale;
  final screenshots = emulators.screenshotHelper(
    iosPath: 'fastlane/screenshots/ios/$locale',
    androidPath:
        'fastlane/metadata/android/$androidLocale/images/$androidImageDirectory',
  );

  setUpAll(() async {
    await driver.waitUntilFirstFrameRasterized();
    await screenshots.cleanStatusBar();
  });

  tearDownAll(() async {
    await driver.close();
  });

  int debugStep = 1;

  Future<void> takeScreenshot(String label, [bool debug = true]) async {
    if (debug && !captureDebug) return;
    final name = debug ? 'd${debugStep++}_$label' : label;
    // ignore: avoid_print
    print('📸 $name');
    await driver.waitUntilNoTransientCallbacks();
    await screenshots.capture(name);
  }

  group('screenshots stroll', () {
    test('init', () async {
      await takeScreenshot('init');
    });

    test('login', () async {
      await driver.enterText(testCredentials.server.toString());
      await driver.sendTextInputAction(TextInputAction.done);
      await takeScreenshot('loginflow-server');

      await driver.waitFor(find.byValueKey(wkLoginFlowClientId));
      await driver.enterText(testCredentials.clientId);
      await driver.sendTextInputAction(TextInputAction.next);
      await driver.enterText(testCredentials.clientSecret);
      await driver.sendTextInputAction(TextInputAction.next);
      await driver.enterText(testCredentials.user);
      await driver.sendTextInputAction(TextInputAction.next);
      await driver.enterText(testCredentials.password);
      await driver.sendTextInputAction(TextInputAction.next);
      await takeScreenshot('loginflow-credentials');
      await driver.tap(find.byValueKey(wkLoginFlowLogIn));
    });

    test('listing', () async {
      await takeScreenshot('listing-loading');
      // hold until the progess indicator is gone
      // this is sub-optimal but will do for now...
      await Future.delayed(const Duration(seconds: 10));
      await takeScreenshot('1-listing', false);

      // FIXME because flutter_drive...
      if (locale == 'zh-Hans') {
        await driver.tap(find.text('未读文章'));
      } else if (locale == 'de-DE') {
        await driver.tap(find.text('Ungelesene'));
      } else {
        await driver.tap(find.byValueKey(wkListingFiltersButton));
      }
      await takeScreenshot('2-filters', false);

      await driver.tap(find.byValueKey(wkListingFiltersCount));
      await takeScreenshot('listing-filters-dismissed');
    });

    openArticle() async {
      await driver.tap(find.text('wallabag turns 10'));
    }

    toggleExpander() async {
      await driver.tap(find.byValueKey(wkArticleExpanderToggle));
    }

    openReadingSettings() async {
      await driver.tap(find.text('wallabag turns 10'));
      await driver.tap(find.byValueKey(wkArticlePopupMenu));
      await driver.tap(find.byValueKey(wkArticlePopupMenuSettings));
    }

    test('reading settings', () async {
      if (deviceType == 'phone') {
        await openArticle();
      } else {
        await toggleExpander();
      }
      await openReadingSettings();
      await takeScreenshot('3-reading-settings', false);

      await driver.tap(find.byType('ModalBarrier'));
      await takeScreenshot('article-settings-dismissed');

      if (deviceType == 'phone') {
        await driver.tap(find.byTooltip(backTooltip));
      } else {
        await toggleExpander();
      }
      await takeScreenshot('listing-back-from-article');
    });

    test('settings and dark mode', () async {
      await driver.tap(find.byValueKey(wkListingSettings));
      await takeScreenshot('4-settings', false);

      await driver.tap(find.byValueKey(wkSettingsTheme));
      await driver.tap(find.text(darkModeLabel));
      if (deviceIsAndroid) {
        await driver.tap(find.text(okCancelLabel));
      }
      await takeScreenshot('settings-dark-theme');

      await driver.tap(find.byTooltip(backTooltip));
      await takeScreenshot('listing-back-from-settings');
    });

    test('reading settings (dark)', () async {
      if (deviceType == 'phone') {
        await openArticle();
      } else {
        await toggleExpander();
      }
      await openReadingSettings();
      await takeScreenshot('5-reading-settings-dark', false);
    });
  });
}
