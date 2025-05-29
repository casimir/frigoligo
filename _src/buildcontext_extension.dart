import 'package:flutter/widgets.dart';
import 'src/generated/i18n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get L => AppLocalizations.of(this)!;
}
