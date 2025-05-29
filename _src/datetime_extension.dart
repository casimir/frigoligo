import 'package:flutter/widgets.dart';

import 'buildcontext_extension.dart';

extension HumanizedStringExtension on DateTime {
  String toHumanizedString(BuildContext context) {
    final now = DateTime.now();
    final diff = now.difference(this);
    String stringed;
    if (diff.inDays.abs() > 0) {
      stringed = context.L.humanize_days(diff.inDays.abs());
    } else if (diff.inHours.abs() > 0) {
      stringed = context.L.humanize_hours(diff.inHours.abs());
    } else if (diff.inMinutes.abs() > 0) {
      stringed = context.L.humanize_minutes(diff.inMinutes.abs());
    } else {
      stringed = context.L.humanize_seconds(diff.inSeconds.abs());
    }
    return diff.isNegative
        ? context.L.humanize_future(stringed)
        : context.L.humanize_past(stringed);
  }
}
