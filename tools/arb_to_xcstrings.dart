#!/usr/bin/env dart
// Converts lib/l10n/*.arb files to ios/Runner/Localizable.xcstrings.
// Usage: dart tools/arb_to_xcstrings.dart

import 'dart:convert';
import 'dart:io';

final _topPluralRe = RegExp(r'^\{(\w+),\s*plural,(.+)\}$', dotAll: true);
final _embeddedPluralRe = RegExp(r'\{(\w+),\s*plural,');
final _placeholderRe = RegExp(r'\{(\w+)\}');

void main() {
  final l10nDir = Directory('lib/l10n');
  final outputFile = File('ios/Runner/Localizable.xcstrings');

  // Load English template for key order and placeholder metadata.
  final enData =
      jsonDecode(File('${l10nDir.path}/app_en.arb').readAsStringSync())
          as Map<String, dynamic>;

  final phTypes = <String, Map<String, String>>{};
  for (final entry in enData.entries) {
    if (!entry.key.startsWith('@')) continue;
    if (entry.value is! Map) continue;
    final realKey = entry.key.substring(1);
    final placeholders =
        (entry.value as Map<String, dynamic>)['placeholders']
            as Map<String, dynamic>?;
    if (placeholders == null) continue;
    phTypes[realKey] = {
      for (final ph in placeholders.entries)
        ph.key:
            ((ph.value as Map<String, dynamic>?))?['type'] as String? ??
            'String',
    };
  }

  // Build strings map in template key order.
  final strings = <String, dynamic>{};
  for (final key in enData.keys) {
    if (key.startsWith('@')) continue;
    final desc =
        (enData['@$key'] as Map<String, dynamic>?)?['description'] as String?;
    strings[key] = {
      if (desc != null && desc.isNotEmpty) 'comment': desc,
      'localizations': <String, dynamic>{},
    };
  }

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
      if (!strings.containsKey(entry.key)) continue;

      final locs =
          (strings[entry.key] as Map<String, dynamic>)['localizations']
              as Map<String, dynamic>;
      locs[locale] = _buildLocalization(
        entry.value as String,
        phTypes[entry.key] ?? {},
      );
    }
  }

  strings.removeWhere(
    (_, v) => ((v as Map<String, dynamic>)['localizations'] as Map).isEmpty,
  );

  if (outputFile.existsSync()) {
    final oldKeys =
        ((jsonDecode(outputFile.readAsStringSync())
                    as Map<String, dynamic>)['strings']
                as Map<String, dynamic>)
            .keys
            .toSet();
    final removed = oldKeys.difference(strings.keys.toSet());
    if (removed.isNotEmpty) {
      stderr.writeln('KEY CHANGES DETECTED:');
      removed.forEach(stderr.writeln);
    }
  }

  final xcstrings = {
    'sourceLanguage': 'en',
    'strings': strings,
    'version': '1.0',
  };

  outputFile.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(xcstrings) + '\n',
  );
  print('Written ${outputFile.path} (${strings.length} strings)');
}

String _localeFromPath(String path) {
  final name = path.split('/').last;
  final m = RegExp(r'app_(.+)\.arb').firstMatch(name);
  return (m?.group(1) ?? 'en').replaceAll('_', '-');
}

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
        'plural': _buildPluralCases(
          _parsePluralBody(topMatch.group(2)!),
          varName,
          type,
        ),
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
        _convertPlaceholders('$prefix%#@${varName}@$suffix', phTypes),
      ),
      'substitutions': {
        varName: {
          'argNum': 1,
          'formatSpecifier': type == 'int' ? 'd' : '@',
          'variations': {
            'plural': _buildPluralCases(_parsePluralBody(body), varName, type),
          },
        },
      },
    };
  }

  // 3. Simple string with optional {placeholder} tokens.
  return {'stringUnit': _stringUnit(_convertPlaceholders(value, phTypes))};
}

String _convertPlaceholders(String value, Map<String, String> phTypes) {
  return value.replaceAllMapped(_placeholderRe, (m) {
    return _formatSpec(phTypes[m.group(1)!] ?? 'String');
  });
}

Map<String, dynamic> _buildPluralCases(
  Map<String, String> cases,
  String varName,
  String type,
) {
  return {
    for (final e in cases.entries)
      _normalizePluralKey(e.key): {
        'stringUnit': _stringUnit(
          e.value.replaceAll('{$varName}', _formatSpec(type)),
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
    while (i < body.length && _isWhitespace(body.codeUnitAt(i))) i++;
    if (i >= body.length) break;

    final keyStart = i;
    while (i < body.length && body[i] != '{') i++;
    final key = body.substring(keyStart, i).trim();
    if (key.isEmpty || i >= body.length) break;

    i++; // skip opening {
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

bool _isWhitespace(int c) => c == 0x20 || c == 0x09 || c == 0x0A || c == 0x0D;

/// Returns info about the first embedded `{var, plural, ...}` in [s], or null.
({String varName, String prefix, String body, String suffix})?
_findEmbeddedPlural(String s) {
  final m = _embeddedPluralRe.firstMatch(s);
  if (m == null) return null;

  int depth = 0;
  int end = -1;
  for (int i = m.start; i < s.length; i++) {
    if (s[i] == '{') depth++;
    if (s[i] == '}') depth--;
    if (depth == 0) {
      end = i;
      break;
    }
  }
  if (end == -1) return null;

  return (
    varName: m.group(1)!,
    prefix: s.substring(0, m.start),
    body: s.substring(m.end, end),
    suffix: s.substring(end + 1),
  );
}
