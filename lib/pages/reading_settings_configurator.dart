import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

import '../buildcontext_extension.dart';
import '../providers/reading_settings.dart';

class ReadingSettingsConfigurator extends ConsumerWidget {
  const ReadingSettingsConfigurator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(readingSettingsProvider);

    return SafeArea(
      child: SingleChildScrollView(
        child: PaddedGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildSection(
                context,
                context.L.readingsettings_fontSize,
                Slider(
                  value: values.fontSize,
                  min: 12.0,
                  max: 20.0,
                  divisions: 4,
                  onChanged:
                      (size) =>
                          ref.read(readingSettingsProvider.notifier).fontSize =
                              size,
                ),
              ),
              C.spacers.verticalContent,
              ..._buildSection(
                context,
                context.L.readingsettings_fontFamily,
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: kSpacingInGroup,
                  runSpacing: !UniversalPlatform.isMobile ? 10.0 : 0.0,
                  children:
                      readingFonts.map((family) {
                        return ChoiceChip(
                          label: Text(
                            family,
                            style: textStyleFromFontFamily(family),
                          ),
                          selected: values.fontFamily == family,
                          onSelected: (selected) {
                            if (selected) {
                              ref
                                  .read(readingSettingsProvider.notifier)
                                  .fontFamily = family;
                            }
                          },
                        );
                      }).toList(),
                ),
              ),
              C.spacers.verticalContent,
              ..._buildSection(
                context,
                context.L.readdingsettings_textFormatting,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SegmentedButton(
                      segments: const [
                        ButtonSegment(
                          value: false,
                          icon: Icon(Icons.format_align_left),
                        ),
                        ButtonSegment(
                          value: true,
                          icon: Icon(Icons.format_align_justify),
                        ),
                      ],
                      selected: {values.justifyText},
                      onSelectionChanged:
                          (selected) =>
                              ref
                                  .read(readingSettingsProvider.notifier)
                                  .justifyText = selected.first,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildSection(BuildContext context, String label, Widget child) {
  return [
    Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    ),
    C.spacers.verticalComponent,
    SizedBox(width: double.infinity, child: child),
  ];
}
