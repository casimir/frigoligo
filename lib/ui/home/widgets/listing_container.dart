import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../buildcontext_extension.dart';
import '../../../dialogs/save.dart';
import '../../../widget_keys.dart';
import '../../core/widgets/remote_sync.dart';
import '../../repository_providers.dart';
import '../controllers/listing_container_controller.dart';
import '../controllers/search_panel_controller.dart';
import 'search_panel.dart';

enum MenuAction { synchronize, saveLink, settings }

class ListingContainer extends ConsumerStatefulWidget {
  const ListingContainer({
    super.key,
    required this.controller,
    required this.child,
  });

  final ListingContainerController controller;
  final Widget child;

  @override
  ConsumerState<ListingContainer> createState() => _ListingContainerState();
}

class _ListingContainerState extends ConsumerState<ListingContainer> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final headerColor = Theme.of(context).colorScheme.surfaceContainerLow;

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
                      queryRepository: ref.watch(queryRepositoryProvider),
                    ),
                    menu: _buildMenu(context, widget.controller),
                    backgroundColor: headerColor,
                  ),
                ),
                const PinnedHeaderSliver(child: RemoteSyncProgressIndicator()),
              ],

          body: widget.child,
        ),
      ),
      floatingActionButton: const RemoteSyncFAB(),
      backgroundColor: headerColor,
      resizeToAvoidBottomInset: false,
      restorationId: 'listing.scaffold',
    );
  }

  PopupMenuButton _buildMenu(
    BuildContext context,
    ListingContainerController controller,
  ) => PopupMenuButton(
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
          MenuAction.synchronize => controller.refresh(),
          MenuAction.settings => context.push('/settings'),
        },
  );
}
