import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../../buildcontext_extension.dart';
import '../../../config/dependencies.dart';
import '../../../dialogs/save.dart';
import '../../../services/remote_sync.dart';
import '../../../widget_keys.dart';
import '../../../widgets/remote_sync_fab.dart';
import '../../../widgets/remote_sync_progress_indicator.dart';
import '../../core/widgets/src/navigation_split_view/navigation_split_view.dart';
import '../controllers/search_panel_controller.dart';
import 'search_panel.dart';

final _log = Logger('frigoligo.listing');

enum MenuAction { synchronize, saveLink, settings }

// FIXME this is a Consumer form only for the use of `ref` in doSave
class ListingContainer extends ConsumerStatefulWidget {
  const ListingContainer({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ListingContainer> createState() => _ListingContainerState();
}

class _ListingContainerState extends ConsumerState<ListingContainer> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final headerColor = Theme.of(context).colorScheme.surfaceContainerLow;
    final navigationSplitViewScope = NavigationSplitViewScope.maybeOf(context);
    final withProgressIndicator =
        navigationSplitViewScope == null ||
        (navigationSplitViewScope.layout ==
                NavigationSplitViewLayout.sideBySide &&
            !navigationSplitViewScope.isContentExpanded);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          key: _scrollKey,
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                PinnedHeaderSliver(
                  child: SearchPanel(
                    controller: SearchPanelController(
                      queryRepository: dependencies.get(),
                    ),
                    menu: _buildMenu(context),
                    backgroundColor: headerColor,
                  ),
                ),
                if (withProgressIndicator)
                  const PinnedHeaderSliver(
                    child: RemoteSyncProgressIndicator(),
                  ),
              ],

          body: widget.child,
        ),
      ),
      floatingActionButton: RemoteSyncFAB(showIf: withProgressIndicator),
      backgroundColor: headerColor,
      resizeToAvoidBottomInset: false,
      restorationId: 'listing.scaffold',
    );
  }

  Future<void> doRefresh() async {
    _log.info('triggered refresh');
    await ref
        .read(remoteSyncerProvider.notifier)
        .synchronize(withFinalRefresh: true);
  }

  PopupMenuButton _buildMenu(BuildContext context) => PopupMenuButton(
    key: const Key(wkListingPopupMenu),
    itemBuilder:
        (context) => [
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
    onSelected:
        (action) => switch (action as MenuAction) {
          MenuAction.saveLink => showSaveUrlDialog(context),
          MenuAction.synchronize => doRefresh(),
          MenuAction.settings => context.push('/settings'),
        },
  );
}
