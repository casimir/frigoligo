import 'dart:async';

import 'package:cadanse/cadanse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:popover/popover.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../dialogs/save.dart';
import '../providers/query.dart';
import '../services/remote_sync.dart';
import '../services/wallabag_storage.dart';
import '../widget_keys.dart';
import '../widgets/remote_sync_fab.dart';
import '../widgets/remote_sync_progress_indicator.dart';
import 'listing/article_list.dart';
import 'listing/search.dart';

final _log = Logger('frigoligo.listing');

const idealListingWidth = 333.3;

class ListingPage extends ConsumerStatefulWidget {
  const ListingPage({
    super.key,
    this.onItemSelect,
    this.withProgressIndicator = true,
    this.sideBySideMode = true,
  });

  final void Function(int articleId)? onItemSelect;
  final bool withProgressIndicator;
  final bool sideBySideMode;

  @override
  ConsumerState<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends ConsumerState<ListingPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(wStorageProvider);

    Future<void> doRefresh() async {
      _log.info('triggered refresh');
      await ref
          .read(remoteSyncerProvider.notifier)
          .synchronize(withFinalRefresh: true);
    }

    // https://api.flutter.dev/flutter/widgets/PinnedHeaderSliver-class.html
    // https://api.flutter.dev/flutter/material/SearchBar-class.html

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const TitleWidget(),
        actions: [
          if (!pullToRefreshSupported)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: doRefresh,
            ),
          IconButton(
            icon: const Icon(Icons.add_link),
            onPressed: () => showSaveUrlDialog(context),
          ),
          IconButton(
            key: const Key(wkListingSettings),
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          PinnedHeaderSliver(
            child: Padding(
              padding: C.paddings.defaultPadding,
              child: ListView(shrinkWrap: true, children: [
                if (widget.withProgressIndicator)
                  const RemoteSyncProgressIndicator(),
                SearchBar(
                  leading: const Icon(Icons.search),
                ),
                C.spacers.verticalContent,
                const SearchFilters(),
              ]),
            ),
          ),
          SliverFillRemaining(
            child: ArticleListView(
              doRefresh: doRefresh,
              onItemSelect: widget.onItemSelect,
              sideBySideMode: widget.sideBySideMode,
            ),
          ),
        ],
      ),
      floatingActionButton: RemoteSyncFAB(showIf: widget.withProgressIndicator),
      restorationId: 'listing.scaffold',
    );
  }
}

class TitleWidget extends ConsumerStatefulWidget {
  const TitleWidget({super.key});

  @override
  ConsumerState<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends ConsumerState<TitleWidget> {
  bool _showingFilters = false;

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(queryProvider);
    var text = switch (query.state!) {
      StateFilter.unread => context.L.listing_articlesUnread,
      StateFilter.archived => context.L.listing_articlesArchived,
      StateFilter.all => context.L.listing_articlesAll,
    };
    if (query.starred == StarredFilter.starred) {
      text += ' (★)';
    }

    return GestureDetector(
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          _showingFilters
              ? const Icon(Icons.expand_less)
              : const Icon(Icons.expand_more),
        ],
      ),
      onTap: () {
        setState(() {
          _showingFilters = !_showingFilters;
        });
        showPopover(
          context: context,
          bodyBuilder: (context) => const FiltersPage(),
          direction: PopoverDirection.top,
          backgroundColor: Theme.of(context).colorScheme.surface,
          transitionDuration: const Duration(milliseconds: 150),
          constraints: const BoxConstraints(maxWidth: idealListingWidth),
          onPop: () => setState(() {
            _showingFilters = false;
          }),
        );
      },
    );
  }
}
