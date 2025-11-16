import 'dart:async';

import 'package:emulators/emulators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:frigoligo/widget_keys.dart';
import 'package:test/test.dart';

import 'localization_loader.dart';
import 'test_credentials.local.dart'; // this is obviously not versioned

const captureDebug = false;

const androidLocaleRewrite = {'zh-Hans': 'zh-CN', 'zh-Hant': 'zh-TW'};

final projectLabels = ProjectLocalizationLoader();
final materialLabels = MaterialLocalizationLoader();

Future<void> main() async {
  final locale = Environment.getString('locale')!;
  final darkModeLabel = projectLabels.getValue(
    locale,
    'settings_valueThemeDark',
  );
  final backTooltip = materialLabels.getValue(locale, 'backButtonTooltip');

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
      // await driver.tap(find.byValueKey(wkLoginFlowLogIn));
    });

    test('listing', () async {
      await takeScreenshot('listing-loading');
      // hold until the progess indicator is gone
      // this is sub-optimal but will do for now...
      final pauseDuration =
          deviceType == 'phone'
              ? const Duration(seconds: 10)
              : const Duration(seconds: 15);
      await Future.delayed(pauseDuration);
      await takeScreenshot('1-listing', false);
    });

    openArticle() async {
      await driver.tap(find.text('wallabag turns 10'));
    }

    toggleExpander() async {
      await driver.tap(find.byValueKey(wkArticleExpanderToggle));
    }

    openReadingSettings() async {
      await driver.tap(find.byValueKey(wkArticleReadingSettings));
    }

    test('reading settings', () async {
      if (deviceType == 'phone') {
        await openArticle();
      } else {
        await toggleExpander();
      }
      await takeScreenshot('article-opened');
      await openReadingSettings();
      await takeScreenshot('2-reading-settings', false);

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
      await driver.tap(find.byValueKey(wkListingPopupMenu));
      await driver.tap(find.byValueKey(wkListingSettings));
      await takeScreenshot('3-settings', false);

      await driver.tap(find.byValueKey(wkSettingsTheme));
      await driver.tap(find.text(darkModeLabel));
      if (deviceIsAndroid) {
        final okButtonLabel = materialLabels.getValue(locale, 'okButtonLabel');
        await driver.tap(find.text(okButtonLabel));
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
      await takeScreenshot('4-reading-settings-dark', false);
    });
  });
}
