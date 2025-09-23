import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/logging.dart';
import '../../../domain/models/log_entry.dart';

class LogEntryMessage extends StatelessWidget {
  const LogEntryMessage({
    super.key,
    required this.entry,
    required this.colorScheme,
    required this.alternativeBackground,
  });

  final LogEntry entry;
  final ColorScheme colorScheme;
  final bool alternativeBackground;

  Color? get _colorForLevel => switch (entry.level) {
    'INFO' => colorScheme.onSurfaceVariant,
    'WARNING' => colorScheme.onSurface,
    'SEVERE' => colorScheme.error,
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    const separator = TextSpan(text: ' ');

    final backgroundColor =
        alternativeBackground
            ? colorScheme.surfaceContainerLowest
            : colorScheme.surfaceContainer;
    final textColor =
        entry.message == startingAppMessage
            ? colorScheme.primary
            : _colorForLevel;
    final timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(entry.time);

    return Container(
      color: backgroundColor,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: timestamp),
            separator,
            TextSpan(text: entry.level.characters.first),
            separator,
            TextSpan(
              text: entry.loggerName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            separator,
            TextSpan(text: entry.message),
            if (entry.error != null) ...[
              separator,
              TextSpan(text: '(${entry.error})'),
            ],
          ],
        ),
        style: TextStyle(color: textColor),
        softWrap: false,
      ),
    );
  }
}
