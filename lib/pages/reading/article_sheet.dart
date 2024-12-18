import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../db/database.dart';
import '../../db/models/article.drift.dart';
import '../../services/remote_sync.dart';
import '../../services/remote_sync_actions/articles.dart';
import '../../widgets/material_sheet.dart';
import '../../widgets/selectors.dart';
import '../../widgets/tag_list.dart';
import 'mixins.dart';

class ArticleSheet extends ConsumerWidget with CurrentArticleWidget {
  const ArticleSheet({super.key});

  @override
  Widget buildArticle(BuildContext context, WidgetRef ref, Article? article) {
    if (article == null) {
      // Should never happer but the mixin signature imposes this check.
      return const SizedBox.shrink();
    }

    return MaterialSheet.side(
      context: context,
      title: context.L.g_article,
      child: SingleChildScrollView(
        child: PaddedGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildField(context, context.L.articlefields_title,
                  value: article.title),
              C.spacers.verticalContent,
              ..._buildField(context, context.L.articlefields_website,
                  value: article.domainName ?? article.url),
              C.spacers.verticalContent,
              ..._buildField(context, context.L.articlefields_readingTime,
                  value: context.L.article_readingTime(article.readingTime)),
              C.spacers.verticalContent,
              const Divider(),
              C.spacers.verticalContent,
              Text(
                context.L.articlefields_tags,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              C.spacers.verticalContent,
              article.tags.isNotEmpty
                  ? TagList(
                      tags: article.tags,
                      onTagPressed: (_) =>
                          _showTagsDialog(context, ref, article),
                    )
                  : TextButton(
                      onPressed: () => _showTagsDialog(context, ref, article),
                      child: Text(context.L.article_addTags),
                    ),
              C.spacers.verticalContent,
              const Divider(),
              C.spacers.verticalContent,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _ShareChip(article),
                    C.spacers.horizontalComponent,
                    ActionChip(
                      avatar: const Icon(Icons.open_in_browser),
                      label: Text(context.L.article_openInBrowser),
                      onPressed: () => launchUrl(Uri.parse(article.url)),
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

  List<Widget> _buildField(
    BuildContext context,
    String label, {
    String? value,
    Widget? child,
  }) {
    return [
      Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      C.spacers.verticalComponent,
      child ?? Text(value ?? ''),
    ];
  }
}

void _showTagsDialog(
    BuildContext context, WidgetRef ref, Article article) async {
  final tags = await showBottomSheetSelector(
    context: context,
    title: context.L.filters_articleTags,
    selectionLabelizer: context.L.filters_articleTagsCount,
    entriesBuilder: DB().articlesDao.listAllTags(),
    initialSelection: article.tags.toSet(),
    leadingIcon: const Icon(Icons.label),
    addEntryIcon: const Icon(Icons.new_label_outlined),
  );
  if (tags != null) {
    final syncer = ref.read(remoteSyncerProvider.notifier);
    await syncer.add(EditArticleAction(article.id, tags: tags.toList()));
    await syncer.synchronize();
  }
}

class _ShareChip extends StatefulWidget {
  const _ShareChip(this.article);

  final Article article;

  @override
  State<_ShareChip> createState() => _ShareChipState();
}

class _ShareChipState extends State<_ShareChip> {
  final _shareButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      key: _shareButtonKey,
      avatar: shareIcon,
      label: Text(context.L.g_share),
      onPressed: () {
        final box = context.findRenderObject() as RenderBox?;
        Share.share(
          widget.article.url,
          subject: widget.article.title,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      },
    );
  }
}
