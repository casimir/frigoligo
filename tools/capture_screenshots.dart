import 'dart:io';
import 'package:emulators/emulators.dart';

Future<void> main() async {
  const emulatorIds = {
    // https://developer.apple.com/help/app-store-connect/reference/screenshot-specifications
    'phone': [
      // 'iPhone 15 Plus',
      // 'android_phone',
    ],
    'tablet': [
      // 'iPad Pro (12.9-inch) (6th generation)',
      // 'android_tablet',
    ],
  };
  const configs = [
    // {'locale': 'de-DE'},
    // {'locale': 'en-US'},
    // {'locale': 'fr-FR'},
    // {'locale': 'zh-Hans'},
    // {'locale': 'zh-Hant'},
  ];

  final emulators = await Emulators.build();
  await emulators.shutdownAll();

  // mitigate a cleanup bug in the emulators package by looping manually
  // https://github.com/tim-smart/dart_emulators/issues/20
  for (final entry in emulatorIds.entries) {
    for (final emulatorId in entry.value) {
      for (final c in configs) {
        await emulators.forEach([emulatorId])((device) async {
          final proc = await emulators.drive(
            device,
            'test_driver/main.dart',
            args: ['--no-pub'],
            config: {
              ...c,
              'deviceName': emulatorId,
              'deviceType': entry.key,
            },
          );
          stderr.addStream(proc.stderr);
          await stdout.addStream(proc.stdout);
        });
      }
    }
  }
}
