import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'settings.dart';

part '_g/reading_settings.g.dart';

final _log = Logger('readingsettings');

@riverpod
class ReadingSettings extends _$ReadingSettings {
  @override
  ReaderSettingsValues build() {
    final values = ref.watch(
      settingsProvider.select((it) => it[Sk.readingSettings]),
    );
    try {
      return ReaderSettingsValues.fromJson(values);
    } catch (e) {
      _log.info('failed to load reading settings', e);
      return ReaderSettingsValues();
    }
  }

  void _commit() {
    ref.read(settingsProvider.notifier).set(Sk.readingSettings, state.toJson());
    ref.notifyListeners();
  }

  set fontSize(double size) {
    state.fontSize = size;
    _commit();
  }

  set height(double height) {
    state.height = height;
    _commit();
  }

  set letterSpacing(double spacing) {
    state.letterSpacing = spacing;
    _commit();
  }

  set fontFamily(String family) {
    state.fontFamily = family;
    _commit();
  }

  set justifyText(bool justify) {
    state.justifyText = justify;
    _commit();
  }
}

const readingFonts = [
  'Lato',
  'Montserrat',
  'Literata',
  'Newsreader',
  'Atkinson Hyperlegible',
];
const defaultReadingFont = 'Lato';

TextStyle textStyleFromFontFamily(String family) {
  try {
    return GoogleFonts.getFont(family);
  } catch (e) {
    _log.info('failed to load font $family', e);
    return const TextStyle();
  }
}

@JsonSerializable()
class ReaderSettingsValues {
  // The default values are based on Material's "Body Large" text theme.
  // https://api.flutter.dev/flutter/material/TextTheme-class.html
  ReaderSettingsValues({
    this.fontSize = 16.0,
    this.height = 1.5,
    this.letterSpacing = 0.5,
    this.fontFamily = defaultReadingFont,
    this.justifyText = false,
  });

  double fontSize;
  double height;
  double letterSpacing;
  String fontFamily;
  bool justifyText;

  TextStyle get textStyle => textStyleFromFontFamily(fontFamily).merge(
    TextStyle(fontSize: fontSize, height: height, letterSpacing: letterSpacing),
  );

  factory ReaderSettingsValues.fromJson(Map<String, dynamic> json) =>
      _$ReaderSettingsValuesFromJson(json);
  Map<String, dynamic> toJson() => _$ReaderSettingsValuesToJson(this);
}
