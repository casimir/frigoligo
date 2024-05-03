import 'dart:io';

import 'package:emulators/emulators.dart';

Future<void> main() async {
  const devices = [
    ('android_phone', 'pixel_6'),
    ('android_tablet', 'Nexus 10'),
  ];

  final emulators = await Emulators.build();

  for (final device in devices) {
    print('Creating ${device.$1} ...');
    final proc = await emulators.toolchain.avdmanager([
      'create',
      'avd',
      '--force',
      '--name',
      device.$1,
      '--package',
      'system-images;android-34;google_apis;x86_64',
      // 'system-images;android-34;google_apis;arm64-v8a',
      '--device',
      device.$2,
    ]).process();
    stderr.addStream(proc.stderr);
    await stdout.addStream(proc.stdout);
  }
}
