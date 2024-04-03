import 'dart:async';

import 'package:emulators/emulators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

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
    test('smoke test', () async {
      await takeScreenshot('0-test');
    });
  });
}
