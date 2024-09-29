import 'dart:async';

import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../dialogs/save.dart';
import '../providers/query.dart';
import '../services/remote_sync.dart';
import '../services/wallabag_storage.dart';
import '../widget_keys.dart';
import '../widgets/async/text.dart';
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
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                child: PaddedGroup(
                  padding: C.paddings.group.copyWith(bottom: kSpacingInGroup),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchBar(
                        hintText: context.L.filters_searchbarHint,
                        leading: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.search),
                        ),
                        trailing: [
                          AText(
                            builder: (context) async {
                              final count = await ref
                                  .watch(wStorageProvider.notifier)
                                  .count(ref.watch(queryProvider));
                              return count.toString();
                            },
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (!pullToRefreshSupported)
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: doRefresh,
                            ),
                          IconButton(
                            key: const Key(wkListingSettings),
                            icon: const Icon(Icons.settings),
                            onPressed: () => context.push('/settings'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value.length < 3) value = '';
                          if (value.isEmpty) {
                            ref.read(queryProvider.notifier).clearText();
                          } else {
                            ref
                                .read(queryProvider.notifier)
                                .overrideWith(WQuery(text: value));
                          }
                        },
                        elevation: WidgetStateProperty.all(0.0),
                        shape: WidgetStateProperty.all(
                            const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        )),
                      ),
                      C.spacers.verticalComponent,
                      const SearchFilters(),
                    ],
                  ),
                ),
              ),
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
