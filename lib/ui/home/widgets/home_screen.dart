import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/dependencies.dart';
import '../../../domain/sync/sync_manager.dart';
import '../../article/controllers/article_screen_controller.dart';
import '../../article/widgets/article_screen.dart';
import '../../core/widgets/adaptive.dart';
import '../../core/widgets/future_loader.dart';
import '../../core/widgets/navigation_split_view.dart';
import '../../repository_providers.dart';
import '../controllers/article_entry_controller.dart';
import '../controllers/home_screen_controller.dart';
import '../controllers/listing_container_controller.dart';
import 'article_entry.dart';
import 'listing_container.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    required this.controller,
    this.initialArticleId,
    this.contentBuilder,
  });

  final HomeScreenController controller;
  final int? initialArticleId;
  final ContentBuilder? contentBuilder;

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
    final initialIndex = widget.initialArticleId != null
        ? itemCounter!.getIndexForArticleId(widget.initialArticleId!)
        : null;

    return WindowQuery(
      child: NavigationSplitView(
        itemCount: itemCounter!,
        initialIndex: initialIndex,
        navigationItemBuilder: (context, index) {
          final articleId = itemCounter!.getArticleId(index)!;
          return ArticleEntry(
            key: ValueKey('article-navigation-$articleId'),
            controller: ArticleEntryController(
              queryRepository: ref.watch(queryRepositoryProvider),
              syncManager: SyncManager.instance,
              articleId: articleId,
            ),
          );
        },
        navigationItemExtent: ArticleEntry.itemExtent,
        navigationContainerBuilder: (context, index, child) => ListingContainer(
          controller: ListingContainerController(
            syncManager: SyncManager.instance,
          ),
          child: child,
        ),
        contentBuilder: (context, index) {
          return ArticleScreen(
            key: ValueKey('article-screen-$index'),
            controller: ArticleScreenController(
              syncManager: SyncManager.instance,
              sharingService: dependencies.get(),
              urlLauncherService: dependencies.get(),
              articleId: itemCounter!.getArticleId(index)!,
            ),
            contentBuilder: widget.contentBuilder,
          );
        },
        restorationId: 'home-screen',
      ),
    );
  }
}
