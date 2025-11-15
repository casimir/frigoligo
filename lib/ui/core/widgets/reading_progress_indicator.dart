import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/article.dart';

class ReadingProgressIndicator extends ConsumerWidget
    implements PreferredSizeWidget {
  const ReadingProgressIndicator({super.key});

  @override
  Size get preferredSize {
    // This is the default value of ProgressIndicatorTheme.linearMinHeight. It
    // would be better to not used a fixed value but PreferredSizeWidget doesn't
    // provide the build context.
    // Related issue: https://github.com/flutter/flutter/issues/116136
    return const Size.fromHeight(4.0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(currentReadingProgressProvider);
    final theme = Theme.of(context);

    if (progress == null || progress <= 0) {
      return SizedBox(height: theme.progressIndicatorTheme.linearMinHeight);
    }

    return LinearProgressIndicator(
      value: progress,
      backgroundColor: theme.colorScheme.tertiaryContainer,
      color: theme.colorScheme.secondary,
    );
  }
}
