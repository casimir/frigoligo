import 'dart:async';

import 'package:emulators/emulators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

// this is obviously not versioned
import '../tools/test_credentials.local.dart';

Future<void> main() async {
  final locale = Environment.getString('locale')!;

  final driver = await FlutterDriver.connect();
  final emulators = await Emulators.build();
  final screenshots = emulators.screenshotHelper(
    iosPath: 'ios/fastlane/screenshots/$locale',
    androidPath: 'screenshots/android/$locale',
  );

  setUpAll(() async {
    await driver.waitUntilFirstFrameRasterized();
    await screenshots.cleanStatusBar();
  });

  tearDownAll(() async {
    await driver.close();
  });

  Future<void> takeScreenshot(label) async {
    await driver.waitUntilNoTransientCallbacks();
    await screenshots.capture(label);
  }

  group('screenshots stroll', () {
    test('init', () async {
      await takeScreenshot('init');
    });
    test('login', () async {
      await driver.enterText(TestCredentials.server.toString());
      await driver.sendTextInputAction(TextInputAction.next);
      await takeScreenshot('server-adress');
      await driver.sendTextInputAction(TextInputAction.done);
      await driver.waitUntilNoTransientCallbacks();
      await takeScreenshot('server-login');
    });
  });
}
