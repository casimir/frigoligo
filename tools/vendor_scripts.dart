// ignore_for_file: avoid_print

// Vendors webview npm scripts and regenerates the pubspec asset list,
// iOS manifest, and script tags in test/test.html.

import 'dart:convert';
import 'dart:io';

import 'package:frigoligo/webview_scripts.dart';

const _wwwDir = 'assets/www';
const _wwwScriptsDir = '$_wwwDir/scripts';

final _projectRoot = File.fromUri(Platform.script).parent.parent.path;
final _scriptsDir = '$_projectRoot/$_wwwScriptsDir';

void main() {
  final manifestVersions = _loadManifestVersions();

  for (final script in webViewNpmScripts) {
    _vendor(script, manifestVersions[script.name]);
  }
  _updatePubspec();
  final configContents = {
    for (final s in webViewNpmScripts)
      if (s.preScriptFile != null)
        s.name: File(
          '$_scriptsDir/${s.name}/${s.preScriptFile}',
        ).readAsStringSync(),
  };
  _generateManifest(configContents);
  _updateTestHtml(configContents);
}

Map<String, String> _loadManifestVersions() {
  final manifestFile = File('$_scriptsDir/manifest.json');
  if (!manifestFile.existsSync()) return {};

  final manifest = jsonDecode(manifestFile.readAsStringSync()) as List;
  return {
    for (final e in manifest)
      e['name'] as String: e['version'] as String? ?? '',
  };
}

void _vendor(WebViewNpmScript script, String? manifestVersion) {
  final destBase = '$_scriptsDir/${script.name}';

  if (manifestVersion == script.version &&
      File('$destBase/${_mainJsFile(script)}').existsSync()) {
    print('Using cached ${script.name} ${script.version}');
    return;
  }

  print('Vendoring ${script.name} ${script.version}...');

  final tmpDir = Directory.systemTemp.createTempSync('vendor_${script.name}_');
  try {
    File(
      '${tmpDir.path}/package.json',
    ).writeAsStringSync('{"name":"tmp","version":"0.0.0","private":true}');

    final packages = [
      '${script.npmPackage}@${script.version}',
      ...?script.extraNpmPackages,
    ];
    final result = Process.runSync('npm', [
      'install',
      '--no-save',
      ...packages,
    ], workingDirectory: tmpDir.path);
    if (result.exitCode != 0) {
      stderr.writeln(result.stderr);
      exit(1);
    }

    final nodeModules = '${tmpDir.path}/node_modules';
    for (final entry in script.files.entries) {
      _copyPath('$nodeModules/${entry.key}', '$destBase/${entry.value}');
      print('> $destBase/${entry.value}');
    }
  } finally {
    tmpDir.deleteSync(recursive: true);
  }
}

void _copyPath(String src, String dest) {
  final type = FileSystemEntity.typeSync(src);
  if (type == FileSystemEntityType.file) {
    File(dest).parent.createSync(recursive: true);
    File(src).copySync(dest);
  } else if (type == FileSystemEntityType.directory) {
    Directory(dest).createSync(recursive: true);
    for (final entity in Directory(src).listSync()) {
      final name = entity.uri.pathSegments.lastWhere(
        (s) => s.isNotEmpty,
        orElse: () => '',
      );
      if (name.isNotEmpty) _copyPath(entity.path, '$dest/$name');
    }
  } else {
    throw Exception('Unexpected entity type $type: $src');
  }
}

void _updatePubspec() {
  const begin = '    # BEGIN webview-scripts';
  const end = '    # END webview-scripts';

  final file = File('$_projectRoot/pubspec.yaml');
  final original = file.readAsStringSync();

  final dirs = _assetDirs('$_projectRoot/$_wwwDir', _wwwDir)..sort();
  final lines = '${dirs.map((d) => '    - $d/').join('\n')}\n';

  final updated = _replaceMarkers(original, begin, end, lines);
  file.writeAsStringSync(updated);
  print('Updated pubspec.yaml (${dirs.length} asset dirs)');
}

List<String> _assetDirs(String absPath, String relPath) {
  final result = <String>[];
  bool hasFiles = false;

  for (final entity in Directory(absPath).listSync()) {
    final name = entity.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
    if (name.startsWith('.')) continue;
    if (entity is File) {
      hasFiles = true;
    } else if (entity is Directory) {
      result.addAll(_assetDirs(entity.path, '$relPath/$name'));
    }
  }

  if (hasFiles) result.add(relPath);
  return result;
}

void _generateManifest(Map<String, String> configContents) {
  final entries = <Map<String, dynamic>>[];

  for (final script in webViewCustomScripts) {
    final entry = <String, dynamic>{
      'name': script.name,
      'path': 'assets/www/${script.file}',
      'injectionTime': script.injectionTime.name,
    };
    if (script.copyToFS != null) {
      entry['copyToFS'] = script.copyToFS;
    }
    entries.add(entry);
  }

  for (final script in webViewNpmScripts) {
    final entry = <String, dynamic>{
      'name': script.name,
      'path': 'assets/www/scripts/${script.name}/${_mainJsFile(script)}',
      'injectionTime': script.injectionTime.name,
      'version': script.version,
    };

    if (configContents[script.name] case final configJs?) {
      entry['preScript'] = configJs;
    }

    if (script.postScriptFile case final initFile?) {
      entry['postScript'] = File(
        '$_scriptsDir/${script.name}/$initFile',
      ).readAsStringSync();
    }

    if (script.copyToFS != null) {
      entry['copyToFS'] = script.copyToFS;
    }

    entries.add(entry);
  }

  final json = const JsonEncoder.withIndent('  ').convert(entries);
  File('$_scriptsDir/manifest.json').writeAsStringSync('$json\n');
  print('Generated manifest.json (${entries.length} entries)');
}

void _updateTestHtml(Map<String, String> configContents) {
  final file = File('$_projectRoot/test/test.html');
  var content = file.readAsStringSync();

  for (final time in ScriptInjectionTime.values) {
    final tags = StringBuffer();
    const indent = '  ';
    const scriptsBase = '../assets/www/scripts';

    for (final script in webViewNpmScripts.where(
      (s) => s.injectionTime == time,
    )) {
      final scriptBase = '$scriptsBase/${script.name}';
      if (script.preScriptFile case final f?) {
        tags.writeln('$indent<script src="$scriptBase/$f"></script>');
        if (script.name == 'mathjax') {
          tags.writeln(
            "$indent<script>window.MathJax.output.fontPath = '$scriptBase/fonts/%%FONT%%-font';</script>",
          );
        }
      }
      tags.writeln(
        '$indent<script src="$scriptBase/${_mainJsFile(script)}"></script>',
      );
      if (script.postScriptFile case final f?) {
        tags.writeln('$indent<script src="$scriptBase/$f"></script>');
      }
      tags.writeln();
    }

    for (final script in webViewCustomScripts.where(
      (s) => s.injectionTime == time,
    )) {
      if (script.name == 'scrolling') {
        tags.writeln('$indent<script>');
        tags.writeln(
          "$indent  window.ScrollProgress = { postMessage: (p) => { document.getElementById('progress').textContent = p.toFixed(3); } };",
        );
        tags.writeln('$indent</script>');
      }
      final href = '../$_wwwDir/${script.file}';
      if (script.file.endsWith('.css')) {
        tags.writeln('$indent<link rel="stylesheet" href="$href">');
      } else {
        tags.writeln('$indent<script src="$href"></script>');
      }
    }

    content = _replaceMarkers(
      content,
      '$indent<!-- BEGIN scripts ${time.name} -->',
      '$indent<!-- END scripts ${time.name} -->',
      tags.toString(),
    );
  }

  file.writeAsStringSync(content);
  print('Updated ${file.path}');
}

String _replaceMarkers(
  String content,
  String begin,
  String end,
  String replacement,
) {
  final beginIdx = content.indexOf(begin);
  final endIdx = content.indexOf(end);
  if (beginIdx == -1 || endIdx == -1)
    throw StateError('Markers not found: $begin');
  return '${content.substring(0, beginIdx + begin.length)}\n$replacement${content.substring(endIdx)}';
}

String _mainJsFile(WebViewNpmScript script) =>
    script.files.values.firstWhere((v) => v.endsWith('.js'));
