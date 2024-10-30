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
  late final ScrollController _scroller;

  @override
  void initState() {
    super.initState();
    _scroller = ScrollController();
  }

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(wStorageProvider);

    // CustomerScrollView works perfectly on mobile but creates 2 scrollbar on
    // SideBySide mode.
    // NestedScrollView works perfectly on SideBySide mode but the list scrolls
    // under the header (at least on mobile).

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          ElevatedPinnedHeaderSliver(
            bodyScrollController: _scroller,
            child: SearchBarWithFilters(
              doRefresh: () => doRefresh(ref),
              menu: _buildMenu(context, ref),
            ),
          ),
          if (widget.withProgressIndicator)
            const SliverToBoxAdapter(child: RemoteSyncProgressIndicator()),
          SliverFillRemaining(
            child: ArticleListView(
              controller: _scroller,
              doRefresh: () => doRefresh(ref),
              onItemSelect: widget.onItemSelect,
              sideBySideMode: widget.sideBySideMode,
            ),
          )
        ]),
      ),
      floatingActionButton: RemoteSyncFAB(showIf: widget.withProgressIndicator),
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

class ElevatedPinnedHeaderSliver extends StatefulWidget {
  const ElevatedPinnedHeaderSliver({
    super.key,
    this.bodyScrollController,
    required this.child,
  });

  final ScrollController? bodyScrollController;
  final Widget child;

  @override
  State<ElevatedPinnedHeaderSliver> createState() =>
      _ElevatedPinnedHeaderSliverState();
}

class _ElevatedPinnedHeaderSliverState
    extends State<ElevatedPinnedHeaderSliver> {
  bool _showElevation = false;

  // FIXME it doesn't handle the case when the list is rebuilt (e.g. filters)
  void onTopScrolled() {
    if (_showElevation && widget.bodyScrollController!.position.pixels == 0.0) {
      setState(() {
        _showElevation = false;
      });
    } else if (!_showElevation &&
        widget.bodyScrollController!.position.pixels > 0.0) {
      setState(() {
        _showElevation = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.bodyScrollController?.addListener(onTopScrolled);
  }

  @override
  void dispose() {
    widget.bodyScrollController?.removeListener(onTopScrolled);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinnedHeaderSliver(
      child: Material(
        elevation: _showElevation ? 2.0 : 0.0,
        child: widget.child,
      ),
    );
  }
}
