import 'package:cadanse/cadanse.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../buildcontext_extension.dart';
import '../../../domain/models/query.dart';
import '../../core/widgets/future_loader.dart';
import '../../core/widgets/selectors.dart';
import '../controllers/search_panel_controller.dart';
import '../states.dart';

const kFilterDomainsKey = Key('search.filters.domains');
const kFilterTagsKey = Key('search.filters.tags');

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
                  Expanded(
                    child: SearchBar(
                      hintText: context.L.filters_searchbarHint,
                      trailing: [
                        FutureLoader(
                          future: ref.watch(
                            queryStateProvider.selectAsync(
                              (state) => state.resultCount,
                            ),
                          ),
                          loadingBuilder: (context) {
                            return const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                          errorBuilder: (context, error) {
                            return const SizedBox(
                              width: 16,
                              height: 16,
                              child: Icon(Icons.error_outline, size: 16),
                            );
                          },
                          builder: (context, resultCount) {
                            return Text(
                              resultCount.toString(),
                              style: TextStyle(
                                color: Theme.of(
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
                    _StarredToggle(
                      onSelected: (value) => controller.setOnlyStarred(value),
                    ),
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

class _AsyncFilterWidget<T> extends ConsumerWidget {
  const _AsyncFilterWidget({
    required this.selector,
    required this.loadingBuilder,
    required this.errorBuilder,
    required this.builder,
  });

  final Future<T> Function(WidgetRef) selector;
  final WidgetBuilder loadingBuilder;
  final Widget Function(BuildContext, Object) errorBuilder;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureLoader(
      future: selector(ref),
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      builder: builder,
    );
  }
}

class _TextModeSelector extends StatelessWidget {
  const _TextModeSelector({required this.onSelected});

  final void Function(SearchTextMode) onSelected;

  @override
  Widget build(BuildContext context) {
    return _AsyncFilterWidget(
      selector: (ref) => ref.watch(
        queryStateProvider.selectAsync((state) => state.query.textMode),
      ),
      loadingBuilder: (context) {
        return const IconButton(
          icon: Icon(Icons.manage_search_outlined),
          onPressed: null,
        );
      },
      errorBuilder: (context, error) {
        return const IconButton(
          icon: Icon(Icons.error_outline),
          onPressed: null,
        );
      },
      builder: buildLoaded,
    );
  }

  Widget buildLoaded(BuildContext context, SearchTextMode textMode) {
    Future<void> onTap() async {
      final value = await showBottomSheetSelect(
        context: context,
        builder: (context) => Select(
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
    final tooltip = context.L.filters_searchMode;
    return textMode == SearchTextMode.all
        ? IconButton(icon: iconData, onPressed: onTap, tooltip: tooltip)
        : IconButton.filledTonal(
            icon: iconData,
            onPressed: onTap,
            tooltip: tooltip,
          );
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

Widget _buildLoadingChip(BuildContext context, String label) {
  return FilterChip(label: Text(label), onSelected: null);
}

class _StateSelector extends StatelessWidget {
  const _StateSelector({required this.onSelected});

  final void Function(StateFilter) onSelected;

  @override
  Widget build(BuildContext context) {
    return _AsyncFilterWidget(
      selector: (ref) => ref.watch(
        queryStateProvider.selectAsync((state) => state.query.state),
      ),
      loadingBuilder: (context) =>
          _buildLoadingChip(context, context.L.filters_articleStateAll),
      errorBuilder: (context, error) =>
          _buildLoadingChip(context, context.L.filters_articleStateAll),
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

class _StarredToggle extends StatelessWidget {
  const _StarredToggle({required this.onSelected});

  final void Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return _AsyncFilterWidget(
      selector: (ref) => ref.watch(
        queryStateProvider.selectAsync((state) => state.query.onlyStarred),
      ),
      loadingBuilder: (context) =>
          _buildLoadingChip(context, context.L.filters_articleFavoriteStarred),
      errorBuilder: (context, error) =>
          _buildLoadingChip(context, context.L.filters_articleFavoriteStarred),
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

class _SelectorChoices<T> {
  const _SelectorChoices({
    required this.choices,
    required this.initialSelection,
  });

  final List<T> choices;
  final Set<T> initialSelection;
}

class _MultiSelectFilterChip extends StatelessWidget {
  const _MultiSelectFilterChip({
    required this.chipKey,
    required this.chipLabel,
    required this.selector,
    required this.onSelected,
    required this.labelizer,
    required this.leadingIcon,
  });

  final Key chipKey;
  final String chipLabel;
  final Future<_SelectorChoices<String>> Function(WidgetRef) selector;
  final void Function(List<String>) onSelected;
  final String Function(int) labelizer;
  final Icon leadingIcon;

  @override
  Widget build(BuildContext context) {
    return _AsyncFilterWidget(
      selector: selector,
      loadingBuilder: (context) => _buildLoadingChip(context, chipLabel),
      errorBuilder: (context, error) => _buildLoadingChip(context, chipLabel),
      builder: buildLoaded,
    );
  }

  Widget buildLoaded(BuildContext context, _SelectorChoices<String> choices) {
    Future<void> onTap() async {
      final selected = await showBottomSheetSelector(
        context: context,
        title: chipLabel,
        selectionLabelizer: labelizer,
        entriesBuilder: Future.value(choices.choices),
        initialSelection: choices.initialSelection,
        leadingIcon: leadingIcon,
      );
      if (selected != null) {
        onSelected(selected.toList());
      }
    }

    return SelectorChip(
      key: chipKey,
      selection: choices.initialSelection.toList(),
      onTap: onTap,
      onDeleted: () => onSelected([]),
      labelizer: (count) => count == 0 ? chipLabel : labelizer(count),
    );
  }
}

class _TagsSelector extends StatelessWidget {
  const _TagsSelector({required this.onSelected});

  final void Function(List<String>) onSelected;

  @override
  Widget build(BuildContext context) {
    return _MultiSelectFilterChip(
      chipKey: kFilterTagsKey,
      chipLabel: context.L.filters_articleTags,
      selector: (ref) => ref.watch(
        queryStateProvider.selectAsync(
          (state) => _SelectorChoices(
            choices: state.availableTags,
            initialSelection: state.query.tags.toSet(),
          ),
        ),
      ),
      onSelected: onSelected,
      labelizer: context.L.filters_articleTagsCount,
      leadingIcon: const Icon(Icons.label),
    );
  }
}

class _DomainsSelector extends StatelessWidget {
  const _DomainsSelector({required this.onSelected});

  final void Function(List<String>) onSelected;

  @override
  Widget build(BuildContext context) {
    return _MultiSelectFilterChip(
      chipKey: kFilterDomainsKey,
      chipLabel: context.L.filters_articleDomains,
      selector: (ref) => ref.watch(
        queryStateProvider.selectAsync(
          (state) => _SelectorChoices(
            choices: state.availableDomains,
            initialSelection: state.query.domains.toSet(),
          ),
        ),
      ),
      onSelected: onSelected,
      labelizer: context.L.filters_articleDomainsCount,
      leadingIcon: const Icon(Icons.web),
    );
  }
}
