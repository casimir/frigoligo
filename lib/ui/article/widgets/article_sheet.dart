import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:flutter/material.dart';

import '../../../buildcontext_extension.dart';
import '../../../domain/models/article_data.dart';
import '../../core/widgets/copyable_text.dart';
import '../../core/widgets/selectors.dart';
import '../../core/widgets/tag_list.dart';
import '../controllers/article_sheet_controller.dart';

class ArticleSheet extends StatelessWidget {
  const ArticleSheet({super.key, required this.controller, required this.data});

  final ArticleSheetController controller;
  final ArticleData data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaddedGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildField(
              context,
              context.L.articlefields_title,
              value: data.title,
            ),
            C.spacers.verticalContent,
            ..._buildField(
              context,
              context.L.articlefields_website,
              value: data.domainName ?? data.url,
            ),
            C.spacers.verticalContent,
            ..._buildField(
              context,
              context.L.articlefields_readingTime,
              value: context.L.article_readingTime(data.readingTime),
            ),
            C.spacers.verticalContent,
            ActionChip(
              avatar: const Icon(Icons.refresh),
              label: Text(context.L.article_refetchContent),
              onPressed: () async {
                Navigator.of(context).pop();
                await controller.refetchContent();
              },
            ),
            C.spacers.verticalComponent,
            const Divider(),
            C.spacers.verticalContent,
            Text(
              context.L.articlefields_tags,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            C.spacers.verticalContent,
            data.tags.isNotEmpty
                ? TagList(
                    tags: data.tags,
                    onTagPressed: (_) =>
                        _showTagsDialog(context, controller, data.tags),
                  )
                : TextButton(
                    onPressed: () =>
                        _showTagsDialog(context, controller, data.tags),
                    child: Text(context.L.article_addTags),
                  ),
            C.spacers.verticalContent,
            const Divider(),
            C.spacers.verticalContent,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _ShareChip(controller, data),
                  C.spacers.horizontalComponent,
                  ActionChip(
                    avatar: const Icon(Icons.open_in_browser),
                    label: Text(context.L.article_openInBrowser),
                    onPressed: () =>
                        controller.openInBrowser(Uri.parse(data.url)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildField(
    BuildContext context,
    String label, {
    String? value,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return [
      Text(
        label,
        style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
      C.spacers.verticalComponent,
      CopyableText(text: Text(value ?? '')),
    ];
  }
}

void _showTagsDialog(
  BuildContext context,
  ArticleSheetController controller,
  List<String> articleTags,
) async {
  final tags = await showBottomSheetSelector(
    context: context,
    title: context.L.filters_articleTags,
    selectionLabelizer: context.L.filters_articleTagsCount,
    entriesBuilder: controller.allTags(),
    initialSelection: articleTags.toSet(),
    leadingIcon: const Icon(Icons.label),
    addEntryIcon: const Icon(Icons.new_label_outlined),
  );
  if (tags != null) {
    await controller.setTags(tags.toList());
  }
}

class _ShareChip extends StatelessWidget {
  const _ShareChip(this.controller, this.data);

  final ArticleSheetController controller;
  final ArticleData data;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(Icons.adaptive.share),
      label: Text(context.L.g_share),
      onPressed: () async {
        final box = context.findRenderObject() as RenderBox?;
        final sharePositionOrigin = box!.localToGlobal(Offset.zero) & box.size;
        await controller.share(data.title, data.url, sharePositionOrigin);
      },
    );
  }
}
