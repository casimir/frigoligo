import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../db/extensions/article.dart';
import '../../db/models/article.drift.dart';
import '../../providers/article.dart';
import '../../providers/query.dart';
import '../../services/remote_sync.dart';
import '../../services/remote_sync_actions/articles.dart';
import '../../services/wallabag_storage.dart';
import '../../widgets/article_image_preview.dart';
import '../../widgets/tag_list.dart';
import 'article_list.dart';

class ArticleListItem extends ConsumerStatefulWidget {
  const ArticleListItem({
    super.key,
    required this.article,
    this.onTap,
    required this.showSelection,
  });

  final Article article;
  final void Function(Article)? onTap;
  final bool showSelection;

  @override
  ConsumerState<ArticleListItem> createState() => _ArticleListItemState();
}

class _ArticleListItemState extends ConsumerState<ArticleListItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    // TODO explore https://pub.dev/packages/flutter_slidable
    // TODO GestureDetector on iOS

    _listenToSelectionChange(ref);

    return Ink(
      color: widget.showSelection && _isSelected
          ? Theme.of(context).highlightColor
          : null,
      child: SizedBox(
        height: listingHeight,
        child: InkWell(
          onTap: () => widget.onTap?.call(widget.article),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.article.domainName ??
                                      widget.article.url,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Text(
                                context.L.article_readingTime(
                                    widget.article.readingTime),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            widget.article.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (widget.article.previewPicture != null)
                    ArticleImagePreview(article: widget.article)
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TagList(
                        tags: widget.article.tags,
                        onTagPressed: (tag) => ref
                            .read(queryProvider.notifier)
                            .overrideWith(WQuery(tags: [tag])),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: stateIcons[widget.article.stateValue]!,
                          onPressed: () async {
                            final syncer =
                                ref.read(remoteSyncerProvider.notifier);
                            await syncer.add(EditArticleAction(
                              widget.article.id,
                              archive: widget.article.archivedAt == null,
                            ));
                            await syncer.synchronize();
                          },
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: starredIcons[widget.article.starredValue]!,
                          onPressed: () async {
                            final syncer =
                                ref.read(remoteSyncerProvider.notifier);
                            await syncer.add(EditArticleAction(
                              widget.article.id,
                              starred: widget.article.starredAt == null,
                            ));
                            await syncer.synchronize();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listenToSelectionChange(WidgetRef ref) async {
    final currentArticleId =
        await ref.watch(currentArticleProvider.selectAsync((it) => it?.id));
    if (mounted) {
      setState(() {
        _isSelected = currentArticleId == widget.article.id;
      });
    }
  }
}

class AsyncArticleItem extends ConsumerWidget {
  const AsyncArticleItem({
    super.key,
    required this.article,
    this.onTap,
    required this.showSelection,
  });

  final Article article;
  final void Function(Article)? onTap;
  final bool showSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(currentArticleProvider).when(
          data: (selected) => ArticleListItem(
                article: article,
                onTap: onTap,
                showSelection: showSelection,
              ),
          error: (e, st) => throw Exception('unreachable branch but $e'),
          loading: () => const SizedBox(
                height: listingHeight,
                child: Center(child: CircularProgressIndicator.adaptive()),
              ));
}
