import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../buildcontext_extension.dart';
import '../../../config/dependencies.dart';
import '../../../domain/models/article_data.dart';
import '../../../services/remote_sync.dart';
import '../../../services/remote_sync_actions.dart';
import '../../../widgets/copiable_text.dart';
import '../../../widgets/selectors.dart';
import '../../../widgets/tag_list.dart';

class ArticleSheet extends ConsumerWidget {
  const ArticleSheet({super.key, required this.data});

  final ArticleData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                if (context.mounted) {
                  context.pop();
                }
                final syncer = ref.read(remoteSyncerProvider.notifier);
                await syncer.add(RefetchArticleAction(data.id));
                await syncer.synchronize();
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
                  onTagPressed:
                      (_) => _showTagsDialog(context, ref, data.id, data.tags),
                )
                : TextButton(
                  onPressed:
                      () => _showTagsDialog(context, ref, data.id, data.tags),
                  child: Text(context.L.article_addTags),
                ),
            C.spacers.verticalContent,
            const Divider(),
            C.spacers.verticalContent,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _ShareChip(data.title, data.url),
                  C.spacers.horizontalComponent,
                  ActionChip(
                    avatar: const Icon(Icons.open_in_browser),
                    label: Text(context.L.article_openInBrowser),
                    onPressed: () => launchUrl(Uri.parse(data.url)),
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
    Widget? child,
  }) {
    final valueWidget = child ?? Text(value ?? '');
    return [
      Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
      C.spacers.verticalComponent,
      valueWidget is Text ? CopiableText(valueWidget) : valueWidget,
    ];
  }
}

void _showTagsDialog(
  BuildContext context,
  WidgetRef ref,
  int articleId,
  List<String> articleTags,
) async {
  final TagRepository tagRepository = dependencies.get();
  final tags = await showBottomSheetSelector(
    context: context,
    title: context.L.filters_articleTags,
    selectionLabelizer: context.L.filters_articleTagsCount,
    entriesBuilder: tagRepository.getAll(),
    initialSelection: articleTags.toSet(),
    leadingIcon: const Icon(Icons.label),
    addEntryIcon: const Icon(Icons.new_label_outlined),
  );
  if (tags != null) {
    final syncer = ref.read(remoteSyncerProvider.notifier);
    await syncer.add(EditArticleAction(articleId, tags: tags.toList()));
    await syncer.synchronize();
  }
}

class _ShareChip extends StatefulWidget {
  const _ShareChip(this.title, this.url);

  final String title;
  final String url;

  @override
  State<_ShareChip> createState() => _ShareChipState();
}

class _ShareChipState extends State<_ShareChip> {
  final _shareButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      key: _shareButtonKey,
      avatar: Icon(Icons.adaptive.share),
      label: Text(context.L.g_share),
      onPressed: () {
        final box = context.findRenderObject() as RenderBox?;
        SharePlus.instance.share(
          ShareParams(
            text: widget.url,
            subject: widget.title,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
          ),
        );
      },
    );
  }
}
