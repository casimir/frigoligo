import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../buildcontext_extension.dart';
import '../../../constants.dart';
import '../../../domain/models/article_data.dart';
import '../../core/states.dart';
import '../../core/widgets/async_value_loader.dart';
import '../../core/widgets/tag_list.dart';
import '../controllers/article_entry_controller.dart';

class ArticleEntry extends ConsumerWidget {
  static const double itemExtent = 144;

  const ArticleEntry({super.key, required this.controller});

  final ArticleEntryController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueLoader(
      value: ref.watch(articleStateProvider(controller.articleId)),
      builder: (context, data) => buildLoaded(context, ref, data!),
    );
  }

  Widget buildLoaded(BuildContext context, WidgetRef ref, ArticleData data) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            data.domainName ?? data.url.toString(),
                            style: Theme.of(context).textTheme.labelMedium,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Text(
                          context.L.article_readingTime(data.readingTime),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      data.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            if (data.previewPicture != null)
              _ImagePreview(url: data.previewPicture!, width: 80, height: 80),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 8.0),
                child: TagList(
                  tags: data.tags,
                  onTagPressed: (tag) {
                    controller.changeTagsSearchFilterTo(tag);
                  },
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
                    icon:
                        stateIcons[data.isArchived
                            ? StateFilter.archived
                            : StateFilter.unread]!,
                    onPressed: () {
                      controller.setArchived(!data.isArchived);
                    },
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon:
                        starredIcons[data.isStarred
                            ? StarredFilter.starred
                            : StarredFilter.unstarred]!,
                    onPressed: () {
                      controller.setStarred(!data.isStarred);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        const Divider(thickness: 1, height: 1),
      ],
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({
    required this.url,
    required this.width,
    required this.height,
  });

  final String url;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnyImageView(
      imagePath: url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholderWidget: const CircularProgressIndicator.adaptive(),
      errorWidget: const Icon(Icons.error),
    );
  }
}
