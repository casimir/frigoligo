import 'package:cadanse/cadanse.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../data/services/local/storage/database/daos/articles.dart';
import '../../data/services/local/storage/database/database.dart';
import '../../providers/query.dart';
import '../../widgets/async/text.dart';
import '../../widgets/selectors.dart';

class SearchFilters extends ConsumerWidget {
  const SearchFilters({super.key, this.indent});

  // A widget that is prepended and appended to the filters list.
  final Widget? indent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        if (indent != null) indent!,
        _buildState(context, ref),
        C.spacers.horizontalComponent,
        _buildStarred(context, ref),
        C.spacers.horizontalComponent,
        _buildTags(context, ref),
        C.spacers.horizontalComponent,
        _buildDomains(context, ref),
        if (indent != null) indent!,
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
    return SelectChip(
      title: context.L.filters_articleState,
      initialSelection: StateFilter.all,
      onSelected: (value) =>
          ref.read(queryProvider.notifier).overrideWith(WQuery(state: value)),
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
        entriesBuilder: DB().articlesDao.listAllTags(),
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
    this.backgroundColor,
  });

  final void Function()? doRefresh;
  final PopupMenuButton<T>? menu;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kSpacingInGroup),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacingInGroup),
              child: Row(
                children: [
                  _buildTextMode(context, ref),
                  C.spacers.horizontalComponent,
                  Flexible(
                    child: SearchBar(
                      hintText: context.L.filters_searchbarHint,
                      trailing: [
                        AText(
                          builder: (context) => ref.watch(
                            queryMetaProvider
                                .selectAsync((it) => it.count.toString()),
                          ),
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        C.spacers.horizontalComponent,
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
                      side: WidgetStatePropertyAll(BorderSide(
                          color: Theme.of(context).colorScheme.outline)),
                      shape: const WidgetStatePropertyAll(
                          ContinuousRectangleBorder(
                        // Freely inspired by the FilterChip shape (height / 4)
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      )),
                    ),
                  ),
                  if (menu != null) ...[C.spacers.horizontalComponent, menu!]
                ],
              ),
            ),
            C.spacers.verticalComponent,
            SearchFilters(indent: C.spacers.horizontalContent),
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
              leadingIcon: iconFromTextMode(SearchTextMode.all),
            ),
            DropdownMenuEntry(
              value: SearchTextMode.title,
              label: context.L.filters_searchModeTitle,
              leadingIcon: iconFromTextMode(SearchTextMode.title),
            ),
            DropdownMenuEntry(
              value: SearchTextMode.content,
              label: context.L.filters_searchModeContent,
              leadingIcon: iconFromTextMode(SearchTextMode.content),
            ),
          ],
          initial: textMode ?? SearchTextMode.all,
        ),
      );
      if (value != null) {
        ref.read(queryProvider.notifier).overrideWith(WQuery(textMode: value));
      }
    }

    final iconData = iconFromTextMode(textMode);
    return textMode == null || textMode == SearchTextMode.all
        ? IconButton(icon: iconData, onPressed: onTap)
        : IconButton.filledTonal(icon: iconData, onPressed: onTap);
  }
}

Icon iconFromTextMode(SearchTextMode? textMode) {
  final iconData = switch (textMode ?? SearchTextMode.all) {
    SearchTextMode.all => Icons.manage_search_outlined,
    SearchTextMode.title => Icons.title_outlined,
    SearchTextMode.content => Icons.article_outlined,
  };
  return Icon(iconData);
}
