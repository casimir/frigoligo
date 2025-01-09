// ignore_for_file: avoid_print

import 'dart:io';

const metadataRoot = 'fastlane/metadata';
const androidMetadataRoot = '$metadataRoot/android';
const iosMetadataRoot = '$metadataRoot/ios';

// unsupported languages on Apple App Store
const langSkips = [
  'et',
  'gl-ES',
  'ta-IN',
];
// different language codes for Apple App Store
const langRewrite = {
  'pt': 'pt-PT',
  'ru-RU': 'ru',
  'zh-CN': 'zh-Hans',
  'zh-TW': 'zh-Hant',
};

final versionRE = RegExp(r'version: \d+\.\d+\.\d+\+(\d+)');
const linkTable = {
  'name.txt': 'title.txt',
  'subtitle.txt': 'short_description.txt',
  'description.txt': 'full_description.txt',
};

void main() {
  final langs = detectLanguages(androidMetadataRoot);
  final version = detectVersionNumber();
  print('languages: ${langs.join(', ')}');
  print('app version: $version');
  for (final lang in langs) {
    final iosLang = langRewrite[lang] ?? lang;
    final androidDir = Directory('$androidMetadataRoot/$lang');
    final iosDir = Directory('$iosMetadataRoot/$iosLang');
    manageLinks(androidDir, iosDir, lang);
    manageChangelogs(androidDir, iosDir, lang, version);
  }
}

List<String> detectLanguages(String root) {
  final langs = Directory(root)
      .listSync()
      .whereType<Directory>()
      .map((e) => e.path.split('/').last)
      .where((e) => !langSkips.contains(e))
      .toList();
  langs.sort();
  return langs;
}

int detectVersionNumber() {
  final pubspec = File('pubspec.yaml').readAsStringSync();
  final rawVersion = versionRE.firstMatch(pubspec)![1]!;
  return int.parse(rawVersion);
}

void manageLinks(Directory androidDir, Directory iosDir, String lang) {
  for (final entry in linkTable.entries) {
    final f = File('${iosDir.path}/${entry.key}');
    final target = File('${androidDir.path}/${entry.value}');
    print('> ${f.path} <- ${target.path}');

    if (!iosDir.existsSync()) {
      iosDir.createSync(recursive: true);
    }

    unlinkPath(f.path);
    final relativeTarget = '../../android/$lang/${entry.value}';
    Link(f.path).createSync(relativeTarget);
  }
}

void unlinkPath(String path) {
  try {
    File(path).deleteSync();
  } on FileSystemException {
    // ignore
  }
  try {
    Link(path).deleteSync();
  } on FileSystemException {
    // ignore
  }
}

void manageChangelogs(
    Directory androidDir, Directory iosDir, String lang, int version) {
  final f = File('${iosDir.path}/release_notes.txt');
  var targetSuffix = 'changelogs/$version.txt';
  var target = File('${androidDir.path}/$targetSuffix');

  unlinkPath(f.path);
  if (!target.existsSync()) {
    targetSuffix = 'changelogs/default.txt';
    target = File('${androidDir.path}/$targetSuffix');
  }
  if (!target.existsSync()) return;

  print('> ${f.path} <- ${target.path}');
  final relativeTarget = '../../android/$lang/$targetSuffix';
  Link(f.path).createSync(relativeTarget);
}
