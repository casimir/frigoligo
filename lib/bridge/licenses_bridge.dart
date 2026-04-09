// coverage:ignore-file
import 'package:flutter/foundation.dart';

import '../pigeon/settings.g.dart';

class LicensesBridge implements LicensesFlutterApi {
  LicensesBridge() {
    LicensesFlutterApi.setUp(this);
  }

  @override
  Future<List<NativeLicensePackage>> getLicenses() async {
    final Map<String, List<String>> packageBodies = {};
    await for (final entry in LicenseRegistry.licenses) {
      final body = entry.paragraphs.map((p) => p.text).join('\n\n');
      for (final package in entry.packages) {
        packageBodies.putIfAbsent(package, () => []).add(body);
      }
    }
    return (packageBodies.entries
        .map(
          (e) => NativeLicensePackage(
            name: e.key,
            body: e.value.join('\n\n---\n\n'),
          ),
        )
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name)));
  }
}
