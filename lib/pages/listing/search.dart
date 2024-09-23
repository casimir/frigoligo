import 'package:cadanse/cadanse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../db/database.dart';
import '../../providers/query.dart';
import '../../services/wallabag_storage.dart';
import '../../widgets/chip_filter_menu.dart';
import '../../widgets/selectors.dart';

final chipShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0));
const searchWidgetElevation = 6.0;

class SearchFilters extends ConsumerWidget {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        _buildState(context, ref),
        C.spacers.horizontalComponent,
        _buildStarred(context, ref),
        C.spacers.horizontalComponent,
        _buildTags(context, ref),
        C.spacers.horizontalComponent,
        _buildDomains(context, ref),
      ]),
    );
  }

  Widget _buildState(BuildContext context, WidgetRef ref) {
    final entries = [
      DropdownMenuEntry(
        value: StateFilter.unread,
        label: context.L.filters_articleStateUnread,
        leadingIcon: const Icon(Icons.inbox),
      ),
      DropdownMenuEntry(
        value: StateFilter.archived,
        label: context.L.filters_articleStateArchived,
        leadingIcon: const Icon(Icons.archive),
      ),
      DropdownMenuEntry(
        value: StateFilter.all,
        label: context.L.filters_articleStateAll,
        leadingIcon: const Icon(Icons.filter_none),
      ),
    ];
    return ChipFilterMenu(
      initialSelection: StateFilter.all,
      onSelected: (entry) => ref
          .read(queryProvider.notifier)
          .overrideWith(WQuery(state: entry.value)),
      entries: entries,
      value: ref.watch(queryProvider.select((q) => q.state)),
      chipShape: chipShape,
      chipElevation: searchWidgetElevation,
    );
  }

  Widget _buildStarred(BuildContext context, WidgetRef ref) {
    return FilterChip.elevated(
      label: Text(context.L.filters_articleFavoriteStarred),
      selected: ref.watch(
          queryProvider.select((q) => q.starred == StarredFilter.starred)),
      onSelected: (value) => ref.read(queryProvider.notifier).overrideWith(
          WQuery(starred: value ? StarredFilter.starred : StarredFilter.all)),
      shape: chipShape,
      elevation: searchWidgetElevation,
    );
  }

  Widget _buildTags(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(queryProvider.select((q) => q.tags));
    final hasSelection = selection?.isNotEmpty ?? false;
    return FilterChip.elevated(
      label: hasSelection
          ? Text(context.L.filters_articleTagsCount(selection!.length))
          : Row(children: [
              Text(context.L.filters_articleTags),
              const Icon(Icons.expand_more),
            ]),
      selected: hasSelection,
      onSelected: (_) async {
        final selected = await showBottomSheetSelector(
          context: context,
          title: context.L.filters_articleTags,
          selectionLabelizer: context.L.filters_articleTagsCount,
          entriesBuilder: ref.read(wStorageProvider.notifier).getTags(),
          initialSelection: selection?.toSet(),
        );
        if (selected != null) {
          if (selected.isNotEmpty) {
            ref
                .read(queryProvider.notifier)
                .overrideWith(WQuery(tags: selected.toList()));
          } else {
            ref.read(queryProvider.notifier).clearTags();
          }
        }
      },
      onDeleted:
          hasSelection ? ref.read(queryProvider.notifier).clearTags : null,
      shape: chipShape,
      elevation: searchWidgetElevation,
    );
  }

  Widget _buildDomains(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(queryProvider.select((q) => q.domains));
    final hasSelection = selection?.isNotEmpty ?? false;
    return FilterChip.elevated(
      label: hasSelection
          ? Text(context.L.filters_articleDomainsCount(selection!.length))
          : Row(children: [
              Text(context.L.filters_articleDomains),
              const Icon(Icons.expand_more),
            ]),
      selected: hasSelection,
      onSelected: (_) async {
        final selected = await showBottomSheetSelector(
          context: context,
          title: context.L.filters_articleDomains,
          selectionLabelizer: context.L.filters_articleDomainsCount,
          entriesBuilder: DB().articlesDao.listAllDomains(),
          initialSelection: selection?.toSet(),
        );
        if (selected != null) {
          if (selected.isNotEmpty) {
            ref
                .read(queryProvider.notifier)
                .overrideWith(WQuery(domains: selected.toList()));
          } else {
            ref.read(queryProvider.notifier).clearDomains();
          }
        }
      },
      onDeleted:
          hasSelection ? ref.read(queryProvider.notifier).clearDomains : null,
      shape: chipShape,
      elevation: searchWidgetElevation,
    );
  }
}
