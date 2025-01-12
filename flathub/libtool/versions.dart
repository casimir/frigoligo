import 'dart:io';
import 'dart:math' as math;

typedef RawVersion = (int, String, String);

class Versions {
  static const String fpath = 'flathub/versions.tsv';

  late Map<int, String> _entries;

  Versions() {
    late final List<String> lines;
    try {
      lines = File(fpath).readAsLinesSync();
    } on PathNotFoundException catch (_) {
      lines = [];
    }
    _entries = Map.fromEntries(lines.where((e) => e.isNotEmpty).map((e) {
      final parts = e.split('\t');
      final versionNum = int.parse(parts[0]);
      final versionName = parts.sublist(1).join('\t');
      return MapEntry(versionNum, versionName);
    }));
  }

  Iterable<RawVersion> get anteChronological {
    final nums = _entries.keys.toList()..sort();
    return nums.reversed.map((e) {
      final parts = _entries[e]!.split('\t');
      return (e, parts[0], parts[1]);
    });
  }

  RawVersion get latest {
    final max = _entries.keys.reduce(math.max);
    final parts = _entries[max]!.split('\t');
    return (max, parts[0], parts[1]);
  }

  void updateAppVersion() {
    final lines = File('pubspec.yaml').readAsLinesSync();
    late final String rawVersion;
    for (final it in lines) {
      if (it.startsWith('version: ')) {
        rawVersion = it.substring(9);
        break;
      }
    }

    final parts = rawVersion.split('+');
    final versionNum = int.parse(parts[1]);
    final date = DateTime.now().toIso8601String().split('T').first;
    final versionName = 'v${parts[0]}\t$date';

    if (_entries[versionNum] != versionName) {
      _entries[versionNum] = versionName;
    }
  }

  void save() {
    final nums = _entries.keys.toList()..sort();
    var lines = [];
    for (final it in nums) {
      lines.add('$it\t${_entries[it]}');
    }
    File(fpath).writeAsStringSync(lines.join('\n'));
  }
}
