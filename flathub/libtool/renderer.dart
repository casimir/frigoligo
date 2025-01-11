import 'dart:io';

import 'fastlane_metadata.dart';
import 'versions.dart';

// taken from https://flathub.org/languages
const langIndex = [
  ('', 'en-US'),
  ('de', 'de-DE'),
  ('es', 'es-ES'),
  ('et', 'et'),
  ('fr', 'fr-FR'),
  ('gl', 'gl-ES'),
  ('pt', 'pt-PT'),
  ('pt-BR', 'pt-BR'),
  ('ru', 'ru-RU'),
  ('ta', 'ta-IN'),
  ('zh-Hans', 'zh-CN'),
  ('zh-Hant', 'zh-TW'),
];

typedef TextGetter = String? Function(String, String);

String gatherTranslations(TextGetter getter) {
  var translations = [];
  for (final (lang, locale) in langIndex) {
    final text = getter(lang, locale);
    if (text != null) {
      translations.add(text);
    }
  }
  return translations.join('\n');
}

String langAttr(String lang) {
  return lang != '' ? ' xml:lang="$lang"' : '';
}

class Renderer {
  static const templatePath =
      'flathub/net.casimirlab.frigoligo.metainfo.template.xml';
  static const outputPath = 'flathub/net.casimirlab.frigoligo.metainfo.xml';
  static const shift = '  ';

  final Versions versions;
  late String _content;

  Renderer(this.versions) {
    _content = File(templatePath).readAsStringSync();
  }

  void process() {
    _content = _content.replaceAll('%YEAR%', _genYear());
    _content = _content.replaceAll('%SUMMARY%', _genSummary());
    _content = _content.replaceAll('%DESCRIPTION%', _genDescription());
    _content = _content.replaceAll('%RELEASES%', _genReleases());
    _content = _content.replaceAll('%LATEST%', _genLatest());
  }

  void write() {
    File(outputPath).writeAsStringSync(_content, flush: true);
  }

  String _genYear() {
    return DateTime.now().year.toString();
  }

  String _genSummary() {
    return gatherTranslations((lang, locale) {
      final content = FastlaneMetadata(locale).summary?.trim();
      if (content == null) return null;
      return '$shift<summary${langAttr(lang)}>$content</summary>';
    });
  }

  String _genDescription() {
    return [
      '$shift<description>',
      gatherTranslations((lang, locale) {
        final content = FastlaneMetadata(locale).description?.trim();
        if (content == null) return null;
        return [
          '${shift * 2}<p${langAttr(lang)}>',
          ...content.split('\n').map((e) => e.isNotEmpty
              ? '${shift * 3}$e'
              : '${shift * 2}</p>\n${shift * 2}<p${langAttr(lang)}>'),
          '${shift * 2}</p>',
        ].join('\n');
      }),
      '$shift</description>',
    ].join('\n');
  }

  String _genReleases() {
    var lines = [];
    lines.add('$shift<releases>');
    for (final (num, name, date) in versions.chronological) {
      lines.add('${shift * 2}<release version="$name" date="$date">');
      lines.add(
          '${shift * 3}<url type="details">https://github.com/casimir/frigoligo/releases/tag/$name</url>');
      final description = _genReleaseDescription(num);
      if (description != null) {
        lines.add(description);
      }
      lines.add('${shift * 2}</release>');
    }
    lines.add('$shift</releases>');
    return lines.join('\n');
  }

  String? _genReleaseDescription(int num) {
    return [
      '${shift * 3}<description>',
      '${shift * 4}<ul>',
      gatherTranslations((lang, locale) {
        final String? content = FastlaneMetadata(locale).changelog(num)?.trim();
        if (content == null) return null;
        return [
          ...content
              .trim()
              .split('\n')
              .map((e) => e.replaceFirst(RegExp('^\\s*- '), ''))
              .map((e) => '${shift * 5}<li${langAttr(lang)}>$e</li>'),
        ].join('\n');
      }),
      '${shift * 4}</ul>',
      '${shift * 3}</description>',
    ].join('\n');
  }

  String _genLatest() {
    final (_, name, _) = versions.latest;
    return name;
  }
}
