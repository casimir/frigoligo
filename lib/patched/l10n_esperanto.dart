// Copypasta of `l10n_esperanto-2.0.11/lib/src/cupertino.dart` with:
// 1. A new required parameter (since flutter 3.27.0) for CupertinoLocalizationsEo.
// 2. A re-export of MaterialLocalizationsEo to avoid loading the original files.
// See `// PATCH` comments for changes.

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_custom.dart' as date_symbol;
import 'package:intl/date_symbols.dart' as intl;
import 'package:intl/intl.dart' as intl;
import 'package:intl/number_symbols_data.dart' as date_symbol;
import 'package:l10n_esperanto/src/data.dart';

export 'package:l10n_esperanto/src/material.dart' show MaterialLocalizationsEo;

class CupertinoLocalizationsEo extends GlobalCupertinoLocalizations {
  /// Create an instance of the translation bundle for Esperanto.
  ///
  /// For details on the meaning of the arguments, see [GlobalCupertinoLocalizations].
  const CupertinoLocalizationsEo({
    super.localeName = 'eo',
    required super.fullYearFormat,
    required super.dayFormat,
    // PATCH
    required super.weekdayFormat,
    //
    required super.mediumDateFormat,
    required super.singleDigitHourFormat,
    required super.singleDigitMinuteFormat,
    required super.doubleDigitMinuteFormat,
    required super.singleDigitSecondFormat,
    required super.decimalFormat,
  });

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _CupertinoLocalizationsEoDelegate();

  @override
  String get alertDialogLabel => r'Averto';

  @override
  String get anteMeridiemAbbreviation => r'atm.';

  @override
  String get copyButtonLabel => r'Kopii';

  @override
  String get cutButtonLabel => r'Eltranĉi';

  @override
  String get datePickerDateOrderString => 'ymd';

  @override
  String get datePickerDateTimeOrderString => 'date_time_dayPeriod';

  @override
  String? get datePickerHourSemanticsLabelFew => null;

  @override
  String? get datePickerHourSemanticsLabelMany => null;

  @override
  String? get datePickerHourSemanticsLabelOne => r'$hour horo';

  @override
  String get datePickerHourSemanticsLabelOther => r'$hour horo';

  @override
  String? get datePickerHourSemanticsLabelTwo => null;

  @override
  String? get datePickerHourSemanticsLabelZero => null;

  @override
  String? get datePickerMinuteSemanticsLabelFew => null;

  @override
  String? get datePickerMinuteSemanticsLabelMany => null;

  @override
  String? get datePickerMinuteSemanticsLabelOne => '1 minuto';

  @override
  String get datePickerMinuteSemanticsLabelOther => r'$minute minuto';

  @override
  String? get datePickerMinuteSemanticsLabelTwo => null;

  @override
  String? get datePickerMinuteSemanticsLabelZero => null;

  @override
  String get lookUpButtonLabel => 'Elserĉi';

  @override
  String get menuDismissLabel => 'Forĵeti menuon';

  @override
  String get modalBarrierDismissLabel => r'Forĵeti';

  @override
  String get pasteButtonLabel => r'Alglui';

  @override
  String get clearButtonLabel => r'Forviŝi';

  @override
  String get postMeridiemAbbreviation => r'ptm.';

  @override
  String get searchTextFieldPlaceholderLabel => 'Serĉi';

  @override
  String get searchWebButtonLabel => 'Serĉi reton';

  @override
  String get selectAllButtonLabel => r'Elekti ĉiujn';

  @override
  String get shareButtonLabel => 'Kunhavigi';

  @override
  String get tabSemanticsLabelRaw => r'Orelo $tabIndex de $tabCount';

  @override
  String? get timerPickerHourLabelFew => null;

  @override
  String? get timerPickerHourLabelMany => null;

  @override
  String? get timerPickerHourLabelOne => r'horo';

  @override
  String get timerPickerHourLabelOther => r'horo';

  @override
  String? get timerPickerHourLabelTwo => null;

  @override
  String? get timerPickerHourLabelZero => null;

  @override
  String? get timerPickerMinuteLabelFew => null;

  @override
  String? get timerPickerMinuteLabelMany => null;

  @override
  String? get timerPickerMinuteLabelOne => r'min.';

  @override
  String get timerPickerMinuteLabelOther => r'min.';

  @override
  String? get timerPickerMinuteLabelTwo => null;

  @override
  String? get timerPickerMinuteLabelZero => null;

  @override
  String? get timerPickerSecondLabelFew => null;

  @override
  String? get timerPickerSecondLabelMany => null;

  @override
  String? get timerPickerSecondLabelOne => r'sek.';

  @override
  String get timerPickerSecondLabelOther => r'sek.';

  @override
  String? get timerPickerSecondLabelTwo => null;

  @override
  String? get timerPickerSecondLabelZero => null;

  @override
  String get todayLabel => r'Hodiaŭ';

  @override
  String datePickerMonth(int monthIndex) {
    final months = eoDateSymbols['STANDALONEMONTHS'] as List<String>;
    return months[monthIndex - 1];
  }

  @override
  String get noSpellCheckReplacementsLabel => r'Neniuj anstataŭaĵoj trovitaj';
}

class _CupertinoLocalizationsEoDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CupertinoLocalizationsEoDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'eo';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    final String localeName = intl.Intl.canonicalizedLocale(locale.toString());
    date_symbol.initializeDateFormattingCustom(
      locale: localeName,
      patterns: eoDatePatterns,
      symbols: intl.DateSymbols.deserializeFromMap(eoDateSymbols),
    );
    date_symbol.numberFormatSymbols[localeName] = eoNumberSymbols;
    date_symbol.compactNumberSymbols[localeName] = eoCompactNumberSymbols;

    return SynchronousFuture<CupertinoLocalizations>(
      CupertinoLocalizationsEo(
        localeName: localeName,
        fullYearFormat: intl.DateFormat('y', localeName),
        // PATCH
        weekdayFormat: intl.DateFormat('EEEE', localeName),
        //
        mediumDateFormat: intl.DateFormat("EEE, d'-a de' MMM", localeName),
        decimalFormat: intl.NumberFormat('#,##0.###', 'hu'),
        singleDigitMinuteFormat: intl.DateFormat('m', localeName),
        singleDigitHourFormat: intl.DateFormat('H', localeName),
        doubleDigitMinuteFormat: intl.DateFormat('mm', localeName),
        dayFormat: intl.DateFormat('d', localeName),
        singleDigitSecondFormat: intl.DateFormat('s', localeName),
      ),
    );
  }

  @override
  bool shouldReload(_CupertinoLocalizationsEoDelegate old) => false;
}
