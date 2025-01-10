import 'dart:io';

class FastlaneMetadata {
  static const rootPath = 'fastlane/metadata/android';

  FastlaneMetadata([this.locale = 'en-US']);

  String locale;

  File _buildFPath(String res) => File('$rootPath/$locale/$res');

  String? _tryRead(String res) {
    try {
      return _buildFPath(res).readAsStringSync();
    } on PathNotFoundException catch (_) {
      return null;
    }
  }

  String? get name => _tryRead('title.txt');

  String? get summary => _tryRead('short_description.txt');

  String? get description => _tryRead('full_description.txt');

  String? changelog(int num) => _tryRead('changelogs/$num.txt');
}
