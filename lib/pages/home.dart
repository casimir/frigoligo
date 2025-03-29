import 'package:cadanse/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app_info.dart';
import '../constants.dart';
import '../providers/expander.dart';
import '../services/remote_sync.dart';
import 'articles/listing.dart';
import 'reading/article.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

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
    if (AppInfo.deviceIsIPhone) {
      // On iPhone the orientation is locked to portrait in build settings. And
      // this the screen size won't change the layout can be static.
      // This is all the more important on iPhone because the software keyboard
      // triggers several MediaQuery invalidation events when it appears and disappears.
      return _buildNarrowLayout();
    }

    // Internally Layout uses MediaQuery. One side effect of this is that on resize
    // almost all widgets are rebuilt.
    return switch (Layout.windowClass(context)) {
      WindowClass.compact || WindowClass.medium => _buildNarrowLayout(),
      WindowClass.expanded => _buildWideLayout(),
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
        if (!expanded) ...[
          const Flexible(
            flex: 1,
            child: ListingPage(),
          ),
          const VerticalDivider(width: 1)
        ],
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
}
