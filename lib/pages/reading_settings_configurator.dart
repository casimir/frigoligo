import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/reading_settings.dart';

const defaultPadding = 10.0;
const defaultSpacing = 16.0;
const leftAlignedInsets = EdgeInsets.only(
  left: defaultSpacing,
  top: defaultPadding,
  right: defaultPadding,
  bottom: defaultPadding,
);

class ReadingSettingsConfigurator extends ConsumerWidget {
  const ReadingSettingsConfigurator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(readingSettingsProvider);

    return ListView(
      shrinkWrap: true,
      children: [
        _buildSectionHeader(context, 'Font size'), // TODO translate
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          // padding: leftAlignedInsets,
          child: Slider(
            value: values.fontSize,
            min: 12.0,
            max: 20.0,
            divisions: 4,
            onChanged: (size) {
              ref.read(readingSettingsProvider.notifier).fontSize = size;
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildSectionHeader(BuildContext context, String label) {
  final filterLabelStyle = Theme.of(context)
      .textTheme
      .bodyLarge!
      .copyWith(fontWeight: FontWeight.bold);

  return Padding(
    padding: leftAlignedInsets,
    child: Text(label, style: filterLabelStyle),
  );
}
