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

class SearchFilters extends ConsumerWidget {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChipTheme(
      data: ChipTheme.of(context).copyWith(
        side: WidgetStateBorderSide.resolveWith(
          (states) => states.isEmpty
              ? BorderSide(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest)
              : null,
        ),
      ),
      child: SingleChildScrollView(
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
      ),
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
    );
  }

  Widget _buildStarred(BuildContext context, WidgetRef ref) {
    return FilterChip(
      label: Text(context.L.filters_articleFavoriteStarred),
      selected: ref.watch(
          queryProvider.select((q) => q.starred == StarredFilter.starred)),
      onSelected: (value) => ref.read(queryProvider.notifier).overrideWith(
          WQuery(starred: value ? StarredFilter.starred : StarredFilter.all)),
    );
  }

  Widget _buildTags(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(queryProvider.select((q) => q.tags));
    Future<void> onTap() async {
      final selected = await showBottomSheetSelector(
        context: context,
        title: context.L.filters_articleTags,
        selectionLabelizer: context.L.filters_articleTagsCount,
        entriesBuilder: ref.read(wStorageProvider.notifier).getTags(),
        initialSelection: selection?.toSet(),
        leadingIcon: const Icon(Icons.label),
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
    }

    return SelectorChip(
      selection: selection,
      onTap: onTap,
      onDeleted: () => ref.read(queryProvider.notifier).clearTags(),
      labelizer: (count) => count == 0
          ? context.L.filters_articleTags
          : context.L.filters_articleTagsCount(count),
    );
  }

  Widget _buildDomains(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(queryProvider.select((q) => q.domains));
    Future<void> onTap() async {
      final selected = await showBottomSheetSelector(
        context: context,
        title: context.L.filters_articleDomains,
        selectionLabelizer: context.L.filters_articleDomainsCount,
        entriesBuilder: DB().articlesDao.listAllDomains(),
        initialSelection: selection?.toSet(),
        leadingIcon: const Icon(Icons.web),
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
    }

    return SelectorChip(
      selection: selection,
      onTap: onTap,
      onDeleted: () => ref.read(queryProvider.notifier).clearDomains(),
      labelizer: (count) => count == 0
          ? context.L.filters_articleDomains
          : context.L.filters_articleDomainsCount(count),
    );
  }
}
