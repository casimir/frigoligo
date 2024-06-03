import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

import '../buildcontext_extension.dart';
import '../providers/reading_settings.dart';

const defaultPadding = 10.0;
const defaultSpacing = 16.0;
final defaultRunSpacing = !UniversalPlatform.isMobile ? 10.0 : 0.0;
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
        _buildSectionHeader(context, context.L.readingsettings_fontSize),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
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
        _buildSectionHeader(context, context.L.readingsettings_fontFamily),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: defaultSpacing,
            runSpacing: defaultRunSpacing,
            children: readingFonts.map((family) {
              return ChoiceChip(
                label: Text(
                  family,
                  style: textStyleFromFontFamily(family),
                ),
                selected: values.fontFamily == family,
                onSelected: (selected) {
                  if (selected) {
                    ref.read(readingSettingsProvider.notifier).fontFamily =
                        family;
                  }
                },
              );
            }).toList(),
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
