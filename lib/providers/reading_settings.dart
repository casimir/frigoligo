import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reading_settings.g.dart';

@riverpod
class ReadingSettings extends _$ReadingSettings {
  @override
  ReaderSettingsValues build() => ReaderSettingsValues();

  set fontSize(double size) {
    state.fontSize = size;
    ref.notifyListeners();
  }

  set height(double height) {
    state.height = height;
    ref.notifyListeners();
  }

  set letterSpacing(double spacing) {
    state.letterSpacing = spacing;
    ref.notifyListeners();
  }
}

class ReaderSettingsValues {
// The default values are based on Material's "Body Large" text theme.
// https://api.flutter.dev/flutter/material/TextTheme-class.html
  ReaderSettingsValues({
    this.fontSize = 16.0,
    this.height = 1.5,
    this.letterSpacing = 0.5,
  });

  double fontSize;
  double height;
  double letterSpacing;

  TextStyle get textStyle => TextStyle(
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
      );
}

// FONTS
// sans serif
// serif
// atkinson

// Lato
// Monserrat
// Oswald

// Literata
// Georgia
// IBM Plex Sans
// Newsreader
// Source Sans Pro
// Source Serif Pro

// open dyslexic
