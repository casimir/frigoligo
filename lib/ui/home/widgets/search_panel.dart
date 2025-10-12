import 'package:cadanse/cadanse.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../buildcontext_extension.dart';
import '../../../domain/models/query.dart';
import '../../../widgets/selectors.dart';
import '../../core/widgets/future_loader.dart';
import '../controllers/search_panel_controller.dart';
import '../states.dart';

class SearchPanel extends ConsumerWidget {
  const SearchPanel({
    super.key,
    required this.controller,
    this.menu,
    this.backgroundColor,
  });

  final SearchPanelController controller;
  final PopupMenuButton? menu;
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
                  _TextModeSelector(onSelected: controller.setTextMode),
                  C.spacers.horizontalComponent,
                  Flexible(
                    child: SearchBar(
                      hintText: context.L.filters_searchbarHint,
                      trailing: [
                        FutureLoader(
                          future: ref.watch(
                            queryStateProvider.selectAsync(
                              (state) => state.resultCount,
                            ),
                          ),
                          builder: (context, resultCount) {
                            return Text(
                              resultCount.toString(),
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                              ),
                            );
                          },
                        ),
                        C.spacers.horizontalComponent,
                      ],
                      onChanged: (value) {
                        controller.setText(value);
                      },
                      elevation: WidgetStateProperty.all(0.0),
                      side: WidgetStatePropertyAll(
                        BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      shape: const WidgetStatePropertyAll(
                        ContinuousRectangleBorder(
                          // Freely inspired by the FilterChip shape (height / 4)
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        ),
                      ),
                    ),
                  ),
                  if (menu != null) ...[C.spacers.horizontalComponent, menu!],
                ],
              ),
            ),
            C.spacers.verticalComponent,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kSpacingBetweenGroups,
                ),
                child: Row(
                  spacing: kSpacingInGroup,
                  children: [
                    _StateSelector(onSelected: controller.setState),
                    _StarredToggle(onSelected: controller.setOnlyStarred),
                    _TagsSelector(onSelected: controller.setTags),
                    _DomainsSelector(onSelected: controller.setDomains),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Icon iconFromTextMode(SearchTextMode textMode) {
  final iconData = switch (textMode) {
    SearchTextMode.all => Icons.manage_search_outlined,
    SearchTextMode.title => Icons.title_outlined,
    SearchTextMode.content => Icons.article_outlined,
  };
  return Icon(iconData);
}

class _TextModeSelector extends ConsumerWidget {
  const _TextModeSelector({required this.onSelected});

  final void Function(SearchTextMode) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureLoader(
      future: ref.watch(
        queryStateProvider.selectAsync((state) => state.query.textMode),
      ),
      builder: buildLoaded,
    );
  }

  Widget buildLoaded(BuildContext context, SearchTextMode textMode) {
    Future<void> onTap() async {
      final value = await showBottomSheetSelect(
        context: context,
        builder:
            (context) => Select(
              title: context.L.filters_searchMode,
              entries: [
                DropdownMenuEntry(
                  value: SearchTextMode.all,
                  label: context.L.filters_searchModeAll,
                  leadingIcon: _iconFor(SearchTextMode.all),
                ),
                DropdownMenuEntry(
                  value: SearchTextMode.title,
                  label: context.L.filters_searchModeTitle,
                  leadingIcon: _iconFor(SearchTextMode.title),
                ),
                DropdownMenuEntry(
                  value: SearchTextMode.content,
                  label: context.L.filters_searchModeContent,
                  leadingIcon: _iconFor(SearchTextMode.content),
                ),
              ],
              initial: textMode,
            ),
      );
      if (value != null) {
        onSelected(value);
      }
    }

    final iconData = _iconFor(textMode);
    return textMode == SearchTextMode.all
        ? IconButton(icon: iconData, onPressed: onTap)
        : IconButton.filledTonal(icon: iconData, onPressed: onTap);
  }

  Icon _iconFor(SearchTextMode textMode) {
    final iconData = switch (textMode) {
      SearchTextMode.all => Icons.manage_search_outlined,
      SearchTextMode.title => Icons.title_outlined,
      SearchTextMode.content => Icons.article_outlined,
    };
    return Icon(iconData);
  }
}

class _StateSelector extends ConsumerWidget {
  const _StateSelector({required this.onSelected});

  final void Function(StateFilter) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureLoader(
      future: ref.watch(
        queryStateProvider.selectAsync((state) => state.query.state),
      ),
      builder: buildLoaded,
    );
  }

  Widget buildLoaded(BuildContext context, StateFilter state) {
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
      initialSelection: state,
      onSelected: onSelected,
      entries: entries,
      value: state,
    );
  }
}

class _StarredToggle extends ConsumerWidget {
  const _StarredToggle({required this.onSelected});

  final void Function(bool) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureLoader(
      future: ref.watch(
        queryStateProvider.selectAsync((state) => state.query.onlyStarred),
      ),
      builder: buildLoaded,
    );
  }

  Widget buildLoaded(BuildContext context, bool selected) {
    return FilterChip(
      label: Text(context.L.filters_articleFavoriteStarred),
      selected: selected,
      onSelected: onSelected,
    );
  }
}

class _TagsSelector extends ConsumerWidget {
  const _TagsSelector({required this.onSelected});

  final void Function(List<String>) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureLoader(
      future: ref.watch(
        queryStateProvider.selectAsync(
          (state) => _SelectorChoices(
            choices: state.availableTags,
            initialSelection: state.query.tags.toSet(),
          ),
        ),
      ),
      builder: buildLoaded,
    );
  }

  Widget buildLoaded(
    BuildContext context,
    _SelectorChoices<String> selectorChoices,
  ) {
    Future<void> onTap() async {
      final selected = await showBottomSheetSelector(
        context: context,
        title: context.L.filters_articleTags,
        selectionLabelizer: context.L.filters_articleTagsCount,
        entriesBuilder: Future.value(selectorChoices.choices),
        initialSelection: selectorChoices.initialSelection,
        leadingIcon: const Icon(Icons.label),
      );
      if (selected != null) {
        onSelected(selected.toList());
      }
    }

    return SelectorChip(
      selection: selectorChoices.initialSelection.toList(),
      onTap: onTap,
      onDeleted: () => onSelected([]),
      labelizer:
          (count) =>
              count == 0
                  ? context.L.filters_articleTags
                  : context.L.filters_articleTagsCount(count),
    );
  }
}

class _DomainsSelector extends ConsumerWidget {
  const _DomainsSelector({required this.onSelected});

  final void Function(List<String>) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureLoader(
      future: ref.watch(
        queryStateProvider.selectAsync(
          (state) => _SelectorChoices(
            choices: state.availableDomains,
            initialSelection: state.query.domains.toSet(),
          ),
        ),
      ),
      builder: buildLoaded,
    );
  }

  Widget buildLoaded(
    BuildContext context,
    _SelectorChoices<String> selectorChoices,
  ) {
    Future<void> onTap() async {
      final selected = await showBottomSheetSelector(
        context: context,
        title: context.L.filters_articleDomains,
        selectionLabelizer: context.L.filters_articleDomainsCount,
        entriesBuilder: Future.value(selectorChoices.choices),
        initialSelection: selectorChoices.initialSelection,
        leadingIcon: const Icon(Icons.web),
      );
      if (selected != null) {
        onSelected(selected.toList());
      }
    }

    return SelectorChip(
      selection: selectorChoices.initialSelection.toList(),
      onTap: onTap,
      onDeleted: () => onSelected([]),
      labelizer:
          (count) =>
              count == 0
                  ? context.L.filters_articleDomains
                  : context.L.filters_articleDomainsCount(count),
    );
  }
}

class _SelectorChoices<T> {
  const _SelectorChoices({
    required this.choices,
    required this.initialSelection,
  });

  final List<T> choices;
  final Set<T> initialSelection;
}
