import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'settings.dart';

part 'reading_settings.g.dart';

@riverpod
class ReadingSettings extends _$ReadingSettings {
  @override
  ReaderSettingsValues build() {
    final values = ref.read(settingsProvider)[Sk.readingSettings];
    // FIXME quick an dirty setting init, specify the exception type at least
    try {
      return ReaderSettingsValues.fromJson(values);
    } catch (_) {
      return ReaderSettingsValues();
    }
  }

  void _commit() {
    ref.read(settingsProvider)[Sk.readingSettings] = state.toJson();
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
}

@JsonSerializable()
class ReaderSettingsValues {
// The default values are based on Material's "Body Large" text theme.
// https://api.flutter.dev/flutter/material/TextTheme-class.html
  ReaderSettingsValues({
    this.fontSize = 16.0,
    this.height = 1.5,
    this.letterSpacing = 0.5,
    this.fontFamily = '',
  });

  double fontSize;
  double height;
  double letterSpacing;
  String fontFamily;

  TextStyle get textStyle =>
      textStyleFromFontFamily(fontFamily).merge(TextStyle(
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
      ));

  factory ReaderSettingsValues.fromJson(Map<String, dynamic> json) =>
      _$ReaderSettingsValuesFromJson(json);
  Map<String, dynamic> toJson() => _$ReaderSettingsValuesToJson(this);
}

// TODO select and embed fonts
// FIXME rename this variable
const gfonts = [
  '', // default
  'Lato',
  'Montserrat',
  'Atkinson Hyperlegible',
  'Oswald',
  // -
  'Literata',
  'IBM Plex Sans',
  'Newsreader',
  'Source Sans 3',
  'Source Serif 4',
];

// FONTS
// sans serif
// serif

// open dyslexic
// Georgia

TextStyle textStyleFromFontFamily(String family) {
  if (family.isEmpty) return const TextStyle();
  return GoogleFonts.getFont(family);
}
