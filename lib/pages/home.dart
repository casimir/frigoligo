import 'package:cadanse/layout.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';
import '../providers/expander.dart';
import '../services/remote_sync.dart';
import 'article.dart';
import 'listing.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isFirstInit = false;

  @override
  void initState() {
    super.initState();

    isFirstInit = true;
    if (!periodicSyncSupported) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(remoteSyncerProvider.notifier)
            .synchronize(withFinalRefresh: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (Layout.windowClass(context)) {
      WindowClass.compact => _buildNarrowLayout(),
      WindowClass.medium => _buildWideLayout(),
      WindowClass.expanded => _buildDynamicLayout(),
    };
  }

  Widget _buildNarrowLayout() {
    return ListingPage(
      onItemSelect: (int articleId) => context.push('/articles/current'),
      sideBySideMode: false,
    );
  }

  Widget _buildWideLayout() {
    final expanded = ref.watch(expanderProvider);
    return Row(
      children: [
        if (!expanded)
          const Flexible(
            flex: 1,
            child: ListingPage(),
          ),
        Flexible(
          flex: 2,
          child: ArticlePage(
            withExpander: true,
            withProgressIndicator: expanded,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicLayout() {
    void onItemSelect(int articleId) {
      if (context.canPop()) {
        context.pop();
      }
    }

    final forcedOpen = isFirstInit;
    isFirstInit = false;

    return ArticlePage(
      drawer: SizedBox(
        width: idealListingWidth,
        child: ListingPage(onItemSelect: onItemSelect),
      ),
      forcedDrawerOpen: forcedOpen,
    );
  }
}
