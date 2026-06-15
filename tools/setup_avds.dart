// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

Future<void> main() async {
  const devices = [
    ('android_phone', 'pixel_9'),
    ('android_tablet', 'pixel_tablet'),
  ];

  final abi = await _hostAbi();
  print('Host ABI: $abi');

  for (final device in devices) {
    print('Creating ${device.$1} ...');
    final proc = await Process.start('avdmanager', [
      'create',
      'avd',
      '--force',
      '--name',
      device.$1,
      '--package',
      'system-images;android-36;google_apis;$abi',
      '--device',
      device.$2,
    ]);
    unawaited(proc.stderr.pipe(stderr));
    await proc.stdout.pipe(stdout);
    final exitCode = await proc.exitCode;
    if (exitCode != 0) throw Exception('avdmanager failed (exit $exitCode)');
  }
}

Future<String> _hostAbi() async {
  final result = await Process.run('uname', ['-m']);
  if (result.exitCode != 0) throw Exception('uname failed');
  return switch ((result.stdout as String).trim()) {
    'arm64' || 'aarch64' => 'arm64-v8a',
    _ => 'x86_64',
  };
}
