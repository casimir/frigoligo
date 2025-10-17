import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/remote_sync.dart';
import '../../core/widgets/adaptive.dart';
import '../../core/widgets/future_loader.dart';
import '../../core/widgets/navigation_split_view.dart';
import '../../repository_providers.dart';
import '../controllers/article_entry_controller.dart';
import '../controllers/home_screen_controller.dart';
import '../controllers/listing_container_controller.dart';
import 'article_entry.dart';
import 'article_screen.dart';
import 'listing_container.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.controller});

  final HomeScreenController controller;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ItemCounter? itemCounter;

  @override
  void dispose() {
    itemCounter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureLoader(
      future: widget.controller.getItemCounter(),
      builder: (context, itemCounter) {
        if (mounted) this.itemCounter = itemCounter;
        return buildLoaded(context, ref);
      },
    );
  }

  Widget buildLoaded(BuildContext context, WidgetRef ref) {
    return WindowQuery(
      child: NavigationSplitView(
        itemCount: itemCounter!,
        navigationItemBuilder: (context, index) {
          final articleId = itemCounter!.getArticleId(index)!;
          return ArticleEntry(
            key: ValueKey('article-navigation-$articleId'),
            controller: ArticleEntryController(
              queryRepository: ref.watch(queryRepositoryProvider),
              syncer: ref.read(remoteSyncerProvider.notifier),
              articleId: articleId,
            ),
          );
        },
        navigationItemExtent: ArticleEntry.itemExtent,
        navigationContainerBuilder:
            (context, index, child) => ListingContainer(
              controller: ListingContainerController(
                remoteSyncer: ref.read(remoteSyncerProvider.notifier),
              ),
              child: child,
            ),
        contentBuilder: (context, index) {
          return ArticleScreen(
            key: ValueKey('article-screen-$index'),
            articleId: itemCounter!.getArticleId(index)!,
          );
        },
      ),
    );
  }
}
