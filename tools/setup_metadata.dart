// ignore_for_file: avoid_print

import 'dart:io';

const metadataRoot = 'fastlane/metadata';
const androidMetadataRoot = '$metadataRoot/android';
const iosMetadataRoot = '$metadataRoot/ios';

// unsupported languages on Apple App Store
const langSkips = ['gl-ES'];
// different language codes for Apple App Store
const langRewrite = {
  'zh-CN': 'zh-Hans',
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
    if (lang == 'fr-FR' && f.path.endsWith('subtitle.txt')) {
      createStrippedFile('$androidMetadataRoot/$lang/${entry.value}', f.path);
    } else {
      final relativeTarget = '../../android/$lang/${entry.value}';
      Link(f.path).createSync(relativeTarget);
    }
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

void createStrippedFile(String source, String destination) {
  print('>> creating stripped file for $destination');
  final content = File(source).readAsStringSync();
  final stripped = content.replaceAll('\u202f', ' ');
  File(destination).writeAsStringSync(stripped);
}

void manageChangelogs(
    Directory androidDir, Directory iosDir, String lang, int version) {
  final f = File('${iosDir.path}/release_notes.txt');
  final targetSuffix = 'changelogs/$version.txt';
  final target = File('${androidDir.path}/$targetSuffix');

  unlinkPath(f.path);
  if (!target.existsSync()) return;

  print('> ${f.path} <- ${target.path}');
  final relativeTarget = '../../android/$lang/$targetSuffix';
  Link(f.path).createSync(relativeTarget);
}
