// ignore_for_file: avoid_print

import 'dart:io';

const metadataRoot = 'fastlane/metadata';
const androidMetadataRoot = '$metadataRoot/android';
const iosMetadataRoot = '$metadataRoot/ios';
const linkTable = {
  'name.txt': 'title.txt',
  'subtitle.txt': 'short_description.txt',
  'description.txt': 'full_description.txt',
};

void main() {
  final langs = detectLanguages(androidMetadataRoot);
  print('languages: ${langs.join(', ')}');
  for (final lang in langs) {
    final androidDir = Directory('$androidMetadataRoot/$lang');
    final iosDir = Directory('$iosMetadataRoot/$lang');
    for (final entry in linkTable.entries) {
      final f = File('${iosDir.path}/${entry.key}');
      final target = File('${androidDir.path}/${entry.value}');
      print('> ${f.path} <- ${target.path}');

      unlinkPath(f.path);
      final relativeTarget = '../../android/$lang/${entry.value}';
      Link(f.path).createSync(relativeTarget);
    }
  }
}

List<String> detectLanguages(String root) {
  final langs = Directory(root)
      .listSync()
      .whereType<Directory>()
      .map((e) => e.path.split('/').last)
      .toList();
  langs.sort();
  return langs;
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
