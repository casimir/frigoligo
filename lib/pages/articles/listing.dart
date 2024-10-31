import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../buildcontext_extension.dart';
import '../../dialogs/save.dart';
import '../../services/remote_sync.dart';
import '../../services/wallabag_storage.dart';
import '../../widget_keys.dart';
import '../../widgets/remote_sync_fab.dart';
import '../../widgets/remote_sync_progress_indicator.dart';
import 'article_list.dart';
import 'search.dart';

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
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ref.watch(wStorageProvider);

    final headerColor = Theme.of(context).colorScheme.surfaceContainer;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          key: _scrollKey,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            PinnedHeaderSliver(
              child: SearchBarWithFilters(
                doRefresh: () => doRefresh(ref),
                menu: _buildMenu(context, ref),
                backgroundColor: headerColor,
              ),
            ),
            if (widget.withProgressIndicator)
              const SliverToBoxAdapter(
                child:
                    RemoteSyncProgressIndicator(idleWidget: SizedBox.shrink()),
              ),
          ],
          body: Container(
            color: Theme.of(context).colorScheme.surface,
            child: Builder(builder: (context) {
              return ArticleListView(
                controller: _scrollKey.currentState!.innerController,
                doRefresh: () => doRefresh(ref),
                onItemSelect: widget.onItemSelect,
                sideBySideMode: widget.sideBySideMode,
              );
            }),
          ),
        ),
      ),
      floatingActionButton: RemoteSyncFAB(showIf: widget.withProgressIndicator),
      backgroundColor: headerColor,
      restorationId: 'listing.scaffold',
    );
  }
}

Future<void> doRefresh(WidgetRef ref) async {
  _log.info('triggered refresh');
  await ref
      .read(remoteSyncerProvider.notifier)
      .synchronize(withFinalRefresh: true);
}

enum MenuAction { synchronize, saveLink, settings }

PopupMenuButton _buildMenu(BuildContext context, WidgetRef ref) =>
    PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: MenuAction.saveLink,
          child: ListTile(
            leading: const Icon(Icons.add_link),
            title: Text(context.L.g_saveLink),
          ),
        ),
        PopupMenuItem(
          value: MenuAction.synchronize,
          child: ListTile(
            leading: const Icon(Icons.sync),
            title: Text(context.L.g_synchronize),
          ),
        ),
        PopupMenuItem(
          value: MenuAction.settings,
          child: ListTile(
            key: const Key(wkListingSettings),
            leading: const Icon(Icons.settings),
            title: Text(context.L.g_settings),
          ),
        ),
      ],
      onSelected: (action) => switch (action as MenuAction) {
        MenuAction.saveLink => showSaveUrlDialog(context),
        MenuAction.synchronize => doRefresh(ref),
        MenuAction.settings => context.push('/settings'),
      },
    );
