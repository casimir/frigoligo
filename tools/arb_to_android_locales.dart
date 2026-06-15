// ignore_for_file: avoid_print

// Generates android/app/src/main/res/values-<qualifier>/_locale_marker.xml for
// every non-en ARB locale, so all Flutter locales appear in resources.arsc and
// AGP's generateLocaleConfig can detect them. Mirrors locale extraction from
// arb_to_xcstrings.dart. SSoT: lib/l10n/app_*.arb.

import 'dart:io';

final _localeFromPathRe = RegExp(r'app_(.+)\.arb');

String _arbTag(String path) =>
    _localeFromPathRe.firstMatch(path)?.group(1) ?? 'en';

// BCP-47 tag → Android res qualifier (language-only stays; region/script → b+ form).
String _qualifier(String tag) =>
    tag.contains('_') ? 'b+${tag.replaceAll('_', '+')}' : tag;

const _markerXml =
    '<?xml version="1.0" encoding="utf-8"?>\n'
    '<!-- GENERATED FILE, DO NOT EDIT MANUALLY -->\n'
    '<resources><bool name="frigoligo_locale_marker">true</bool></resources>\n';

void main() {
  final resDir = Directory('android/app/src/main/res');

  final tags = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb'))
      .map((f) => _arbTag(f.path))
      .where((tag) => tag != 'en')
      .toList();

  final qualifiers = {for (final tag in tags) _qualifier(tag)};

  // Delete stale marker dirs no longer backed by an ARB file.
  for (final entry in resDir.listSync().whereType<Directory>()) {
    final name = entry.path.split('/').last;
    if (!name.startsWith('values-')) continue;
    final markerFile = File('${entry.path}/_locale_marker.xml');
    if (markerFile.existsSync() && !qualifiers.contains(name.substring(7))) {
      entry.deleteSync(recursive: true);
      print('Deleted stale ${entry.path}');
    }
  }

  // Write marker for each locale.
  for (final q in (qualifiers.toList()..sort())) {
    final dir = Directory('${resDir.path}/values-$q')..createSync();
    File('${dir.path}/_locale_marker.xml').writeAsStringSync(_markerXml);
  }

  print(
    'Written ${qualifiers.length} locale marker(s): ${(qualifiers.toList()..sort()).join(', ')}',
  );
}
