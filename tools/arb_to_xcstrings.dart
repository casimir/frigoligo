// ignore_for_file: avoid_print

// Converts Flutter ARB localisation files into an iOS Localizable.xcstrings
// file. The xcstrings format was reverse-engineered from Xcode output, so this
// script should not be held to the same standard as the rest of the codebase.

import 'dart:convert';
import 'dart:io';

final _topPluralRe = RegExp(r'^\{(\w+),\s*plural,(.+)\}$', dotAll: true);
final _embeddedPluralRe = RegExp(r'\{(\w+),\s*plural,');
final _placeholderRe = RegExp(r'\{(\w+)\}');
final _localeFromPathRe = RegExp(r'app_(.+)\.arb');
final _xcstringsColonRe = RegExp(r'^(\s+"[^"]*"):', multiLine: true);
final _xcstringsEmptyEntryRe = RegExp(
  r'^(    "[^"]*" : )\{\}(,?)$',
  multiLine: true,
);

class _StringEntry {
  _StringEntry({this.comment});
  final String? comment;
  final Map<String, Map<String, dynamic>> localizations = {};
}

typedef _ArbMeta = ({
  Map<String, _StringEntry> strings,
  Map<String, Map<String, String>> phTypes,
});

/// Parses decoded English ARB data into string entries and placeholder types.
_ArbMeta _parseEnArb(Map<String, dynamic> enData) {
  final strings = <String, _StringEntry>{};
  final phTypes = <String, Map<String, String>>{};

  for (final entry in enData.entries) {
    if (!entry.key.startsWith('@')) {
      strings[entry.key] ??= _StringEntry();
      continue;
    }
    if (entry.value is! Map) continue;
    final key = entry.key.substring(1);
    final meta = entry.value as Map<String, dynamic>;
    strings[key] = _StringEntry(comment: meta['description'] as String?);
    final placeholders = meta['placeholders'] as Map<String, dynamic>?;
    if (placeholders == null) continue;
    phTypes[key] = {
      for (final ph in placeholders.entries)
        ph.key:
            (ph.value as Map<String, dynamic>?)?['type'] as String? ?? 'String',
    };
  }
  return (strings: strings, phTypes: phTypes);
}

void main() {
  final l10nDir = Directory('lib/l10n');
  final outputFile = File('ios/Localizable.xcstrings');

  final enData =
      jsonDecode(File('${l10nDir.path}/app_en.arb').readAsStringSync())
          as Map<String, dynamic>;

  final (:strings, :phTypes) = _parseEnArb(enData);

  final arbFiles =
      l10nDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.arb'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  for (final arbFile in arbFiles) {
    final data = jsonDecode(arbFile.readAsStringSync()) as Map<String, dynamic>;
    final locale = _localeFromPath(arbFile.path);

    for (final entry in data.entries) {
      if (entry.key.startsWith('@')) continue;
      final stringEntry = strings[entry.key];
      if (stringEntry == null) continue;
      stringEntry.localizations[locale] = _buildLocalization(
        entry.value as String,
        phTypes[entry.key] ?? {},
      );
    }
  }

  strings.removeWhere((_, v) => v.localizations.isEmpty);

  final Map<String, dynamic> nativeEntries = {};
  final Map<String, String> preservedExtractionState = {};
  if (outputFile.existsSync()) {
    final oldData =
        jsonDecode(outputFile.readAsStringSync()) as Map<String, dynamic>;
    final oldStrings = oldData['strings'] as Map<String, dynamic>;
    for (final e in oldStrings.entries) {
      if (!strings.containsKey(e.key) && (e.value as Map).isEmpty) {
        nativeEntries[e.key] = e.value;
      }
      final oldEntry = e.value as Map<String, dynamic>;
      if (oldEntry.containsKey('extractionState')) {
        preservedExtractionState[e.key] = oldEntry['extractionState'] as String;
      }
    }
  }

  // Merge native (empty) entries with ARB entries, preserve extractionState.
  final allEntries = <String, dynamic>{
    ...nativeEntries,
    for (final e in strings.entries)
      e.key: {
        if (e.value.comment?.isNotEmpty == true) 'comment': e.value.comment,
        if (preservedExtractionState[e.key] != null)
          'extractionState': preservedExtractionState[e.key],
        'localizations': e.value.localizations,
      },
  };
  final sortedKeys = allEntries.keys.toList()
    ..sort((a, b) {
      if (a == '·') return -1;
      if (b == '·') return 1;
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
  final xcstrings = {
    'sourceLanguage': 'en',
    'strings': {for (final k in sortedKeys) k: allEntries[k]},
    'version': '1.0',
  };

  const encoder = JsonEncoder.withIndent('  ');
  // Match Xcode's xcstrings formatting.
  final json = encoder
      .convert(xcstrings)
      // Space before colon on key-value lines.
      .replaceAllMapped(_xcstringsColonRe, (m) => '${m[1]} :')
      // Native (Xcode-managed) string entries are empty objects. Xcode formats
      // them as "key" : {\n\n    } instead of "key" : {}.
      .replaceAllMapped(
        _xcstringsEmptyEntryRe,
        (m) => '${m[1]}{\n\n    }${m[2]}',
      );
  outputFile.writeAsStringSync(json);
  print('Written ${outputFile.path} (${strings.length} strings)');
}

String _localeFromPath(String path) =>
    (_localeFromPathRe.firstMatch(path)?.group(1) ?? 'en').replaceAll('_', '-');

String _formatSpec(String type) => type == 'int' ? '%lld' : '%@';

Map<String, dynamic> _stringUnit(String value) => {
  'state': 'translated',
  'value': value,
};

Map<String, dynamic> _buildLocalization(
  String value,
  Map<String, String> phTypes,
) {
  // 1. Top-level plural: entire value is {var, plural, ...}.
  final topMatch = _topPluralRe.firstMatch(value);
  if (topMatch != null) {
    final varName = topMatch.group(1)!;
    final type = phTypes[varName] ?? 'String';
    return {
      'variations': {
        'plural': _buildPluralCases(topMatch.group(2)!, varName, type),
      },
    };
  }

  // 2. Embedded plural: {var, plural, ...} inside a larger string.
  final embedded = _findEmbeddedPlural(value);
  if (embedded != null) {
    final (:varName, :prefix, :body, :suffix) = embedded;
    final type = phTypes[varName] ?? 'String';
    return {
      'stringUnit': _stringUnit(
        _convertPlaceholders('$prefix%#@$varName@$suffix', phTypes),
      ),
      'substitutions': {
        varName: {
          'argNum': 1,
          'formatSpecifier': type == 'int' ? 'd' : '@',
          'variations': {'plural': _buildPluralCases(body, varName, type)},
        },
      },
    };
  }

  // 3. Simple string with optional {placeholder} tokens.
  return {'stringUnit': _stringUnit(_convertPlaceholders(value, phTypes))};
}

Map<String, dynamic> _buildEntry(_StringEntry entry, String? extractionState) {
  return {
    if (entry.comment?.isNotEmpty == true) 'comment': entry.comment,
    if (extractionState != null) 'extractionState': extractionState,
    'localizations': entry.localizations,
  };
}

String _convertPlaceholders(String value, Map<String, String> phTypes) =>
    value.replaceAllMapped(
      _placeholderRe,
      (m) => _formatSpec(phTypes[m.group(1)!] ?? 'String'),
    );

Map<String, dynamic> _buildPluralCases(
  String body,
  String varName,
  String type,
) {
  final cases = {
    for (final e in _parsePluralBody(body).entries)
      _normalizePluralKey(e.key): e.value,
  };
  return {
    for (final key in cases.keys.toList()..sort())
      key: {
        'stringUnit': _stringUnit(
          cases[key]!.replaceAll('{$varName}', _formatSpec(type)),
        ),
      },
  };
}

String _normalizePluralKey(String key) => switch (key) {
  '=0' => 'zero',
  '=1' => 'one',
  '=2' => 'two',
  final k => k,
};

/// Parses an ICU plural body (the part after `{var, plural,`) into case→value.
Map<String, String> _parsePluralBody(String body) {
  final cases = <String, String>{};
  int i = 0;
  while (i < body.length) {
    final keyStart = i;
    while (i < body.length && body[i] != '{') {
      i++;
    }
    final key = body.substring(keyStart, i).trim();
    if (key.isEmpty || i >= body.length) break;

    i++;
    int depth = 1;
    final valStart = i;
    while (i < body.length && depth > 0) {
      if (body[i] == '{') depth++;
      if (body[i] == '}') depth--;
      i++;
    }
    cases[key] = body.substring(valStart, i - 1);
  }
  return cases;
}

/// Returns info about the first embedded `{var, plural, ...}` in [s], or null.
({String varName, String prefix, String body, String suffix})?
_findEmbeddedPlural(String s) {
  final m = _embeddedPluralRe.firstMatch(s);
  if (m == null) return null;

  int depth = 0;
  for (int i = m.start; i < s.length; i++) {
    if (s[i] == '{') depth++;
    if (s[i] == '}') depth--;
    if (depth == 0) {
      return (
        varName: m.group(1)!,
        prefix: s.substring(0, m.start),
        body: s.substring(m.end, i),
        suffix: s.substring(i + 1),
      );
    }
  }
  return null;
}
