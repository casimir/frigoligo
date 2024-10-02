import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../db/daos/articles.dart';
import '../../db/database.dart';
import '../../providers/query.dart';
import '../../services/wallabag_storage.dart';
import '../../widgets/async/text.dart';
import '../../widgets/chip_filter_menu.dart';
import '../../widgets/selectors.dart';

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

class SearchBarWithFilters<T> extends ConsumerWidget {
  const SearchBarWithFilters({
    super.key,
    required this.doRefresh,
    this.menu,
  });

  final void Function()? doRefresh;
  final PopupMenuButton<T>? menu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
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
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                _buildTextMode(context, ref),
                if (menu != null) menu!,
              ],
              onChanged: (value) {
                if (value.isEmpty) {
                  ref.read(queryProvider.notifier).clearText();
                } else {
                  ref
                      .read(queryProvider.notifier)
                      .overrideWith(WQuery(text: value));
                }
              },
              elevation: WidgetStateProperty.all(0.0),
              backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.surface),
              side: WidgetStatePropertyAll(
                BorderSide(color: Theme.of(context).colorScheme.onSurface),
              ),
              shape: const WidgetStatePropertyAll(ContinuousRectangleBorder(
                // Freely inspired by the FilterChip shape (height / 4)
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              )),
            ),
            C.spacers.verticalComponent,
            const SearchFilters(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextMode(BuildContext context, WidgetRef ref) {
    final textMode = ref.watch(queryProvider.select((q) => q.textMode));

    Future<void> onTap() async {
      final value = await showBottomSheetSelect(
        context: context,
        builder: (context) => Select(
          title: context.L.filters_searchMode,
          entries: [
            DropdownMenuEntry(
              value: SearchTextMode.all,
              label: context.L.filters_searchModeAll,
              leadingIcon: const Icon(Icons.text_fields),
            ),
            DropdownMenuEntry(
              value: SearchTextMode.title,
              label: context.L.filters_searchModeTitle,
              leadingIcon: const Icon(Icons.title),
            ),
            DropdownMenuEntry(
              value: SearchTextMode.content,
              label: context.L.filters_searchModeContent,
              leadingIcon: const Icon(Icons.article),
            ),
          ],
          initial: textMode,
        ),
      );
      if (value != null) {
        ref.read(queryProvider.notifier).overrideWith(WQuery(textMode: value));
      }
    }

    final iconData = switch (textMode) {
      SearchTextMode.all => Icons.text_fields,
      SearchTextMode.title => Icons.title,
      SearchTextMode.content => Icons.article,
    };
    return IconButton(
      icon: Icon(iconData),
      onPressed: onTap,
    );
  }
}
