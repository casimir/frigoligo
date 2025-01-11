import 'dart:io';

class FastlaneMetadata {
  static const rootPath = 'fastlane/metadata/android';

  FastlaneMetadata([this.locale = 'en-US', this.followLinks = false]);

  final String locale;
  final bool followLinks;

  String? _tryRead(String res) {
    final fname = '$rootPath/$locale/$res';

    if (!followLinks && Link(fname).existsSync()) {
      return null;
    }

    try {
      return File(fname).readAsStringSync();
    } on PathNotFoundException catch (_) {
      return null;
    }
  }

  String? get name => _tryRead('title.txt');

  String? get summary => _tryRead('short_description.txt');

  String? get description => _tryRead('full_description.txt');

  String? changelog(int num) => _tryRead('changelogs/$num.txt');
}
