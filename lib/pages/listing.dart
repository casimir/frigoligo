import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../dialogs/save.dart';
import '../services/remote_sync.dart';
import '../services/wallabag_storage.dart';
import '../widgets/remote_sync_fab.dart';
import '../widgets/remote_sync_progress_indicator.dart';
import 'listing/article_list.dart';
import 'listing/search.dart';

final _log = Logger('frigoligo.listing');

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

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            PinnedHeaderSliver(
              child: SearchBarWithFilters(doRefresh: doRefresh),
            ),
            SliverToBoxAdapter(
              child: widget.withProgressIndicator
                  ? const RemoteSyncProgressIndicator(
                      idleWidget:
                          Divider(height: kM3LinearProgressIndicatorHeight))
                  : const Divider(height: kM3LinearProgressIndicatorHeight),
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
      ),
      floatingActionButton: RemoteSyncFAB(
        showIf: widget.withProgressIndicator,
        alternativeChild: FloatingActionButton(
          onPressed: () => showSaveUrlDialog(context),
          shape: const CircleBorder(),
          child: const Icon(Icons.add_link),
        ),
      ),
      restorationId: 'listing.scaffold',
    );
  }
}
