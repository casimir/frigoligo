import 'package:flutter/widgets.dart';
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
}

@JsonSerializable()
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

  factory ReaderSettingsValues.fromJson(Map<String, dynamic> json) =>
      _$ReaderSettingsValuesFromJson(json);
  Map<String, dynamic> toJson() => _$ReaderSettingsValuesToJson(this);
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
