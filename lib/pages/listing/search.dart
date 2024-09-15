import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../db/database.dart';
import '../../providers/query.dart';
import '../../services/wallabag_storage.dart';
import '../../widget_keys.dart';
import '../../widgets/async/text.dart';
import '../../widgets/chip_filter_menu.dart';
import '../../widgets/selectors.dart';
import '../../widgets/tag_list.dart';
import '../tags_selector/dialog.dart';

const defaultPadding = 10.0;
const defaultSpacing = 16.0;
const leftAlignedInsets = EdgeInsets.only(
  left: defaultSpacing,
  top: defaultPadding,
  right: defaultPadding,
  bottom: defaultPadding,
);
// TODO move to cadanse
const spaceHorizontalInGroup = SizedBox(width: 8.0);

final chipShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0));
const searchWidgetElevation = 6.0;

// TODO delete unused
class FiltersPage extends ConsumerWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(wStorageProvider);

    final storage = ref.watch(wStorageProvider.notifier);
    final query = ref.watch(queryProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFilterHeader(context, context.L.filters_articleState),
            _buildCount(context, storage.count(query)),
          ],
        ),
        _buildFilterChoices(_buildStateFilterChoices(context, ref)),
        _buildFilterHeader(context, context.L.filters_articleFavorite),
        _buildFilterChoices(_buildStarredFilterChoices(context, ref)),
        _buildFilterHeader(context, context.L.filters_articleTags),
        _buildTagsSelector(context, ref),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}

Widget _buildCount(BuildContext context, Future<int> count) {
  final widget = Padding(
    key: const ValueKey(wkListingFiltersCount),
    padding: const EdgeInsets.only(right: 8.0),
    child: AText(
      builder: (context) async => context.L.filters_articlesCount(await count),
    ),
  );
  // allow to close the dialog by tapping the count in debug mode for automation
  return kDebugMode
      ? GestureDetector(
          child: widget,
          onTap: () => context.pop(),
        )
      : widget;
}

Widget _buildFilterHeader(BuildContext context, String label) {
  final filterLabelStyle = Theme.of(context)
      .textTheme
      .bodyLarge!
      .copyWith(fontWeight: FontWeight.bold);

  return Padding(
    padding: leftAlignedInsets,
    child: Text(label, style: filterLabelStyle),
  );
}

Widget _buildFilterChoices(List<Widget> children) {
  return Card(
    shape: const Border(),
    margin: EdgeInsets.zero,
    child: Padding(
      padding: leftAlignedInsets,
      child: Wrap(
        spacing: defaultSpacing,
        children: children,
      ),
    ),
  );
}

ChoiceChip _makeChoiceChip<T extends Enum>(
    T value, String label, T? selected, void Function(bool) onSelected) {
  return ChoiceChip(
    label: Text(label),
    onSelected: onSelected,
    selected: value == selected,
    showCheckmark: false,
  );
}

List<ChoiceChip> _buildStateFilterChoices(BuildContext context, WidgetRef ref) {
  final labels = {
    StateFilter.unread: context.L.filters_articleStateUnread,
    StateFilter.archived: context.L.filters_articleStateArchived,
    StateFilter.all: context.L.filters_articleStateAll,
  };
  final query = ref.watch(queryProvider);

  return List.generate(
    StateFilter.values.length,
    (index) => _makeChoiceChip(
      StateFilter.values[index],
      labels[StateFilter.values[index]]!,
      query.state,
      (selected) {
        if (selected) {
          var wq = query.dup();
          wq.state = StateFilter.values[index];
          ref.read(queryProvider.notifier).set(wq);
        }
      },
    ),
  );
}

List<ChoiceChip> _buildStarredFilterChoices(
    BuildContext context, WidgetRef ref) {
  final query = ref.watch(queryProvider);

  void Function(bool) onSelected(StarredFilter value) {
    return (selected) {
      if (!selected) return;
      var wq = query.dup();
      wq.starred = value;
      ref.read(queryProvider.notifier).set(wq);
    };
  }

  return [
    _makeChoiceChip(
      StarredFilter.all,
      context.L.filters_articleFavoriteAll,
      query.starred ?? StarredFilter.all,
      onSelected(StarredFilter.all),
    ),
    _makeChoiceChip(
      StarredFilter.starred,
      context.L.filters_articleFavoriteStarred,
      query.starred,
      onSelected(StarredFilter.starred),
    ),
  ];
}

Widget _buildTagsSelector(BuildContext context, WidgetRef ref) {
  final query = ref.watch(queryProvider);
  final selection = query.tags?.isNotEmpty ?? false
      ? TagList(
          tags: query.tags!,
          onTagPressed: (_) => _showTagsSelectionDialog(context, ref),
        )
      : Padding(
          // make the Card at least the same height than the others
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(context.L.filters_noTagsSelected),
        );

  return Card(
    shape: const Border(),
    margin: EdgeInsets.zero,
    child: Padding(
      padding: leftAlignedInsets,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: defaultSpacing,
        children: [
          InkWell(
            child: Row(
              children: [
                Expanded(child: Wrap(children: [selection])),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
            onTap: () => _showTagsSelectionDialog(context, ref),
          ),
          if (query.tags?.isNotEmpty ?? false)
            TextButton(
              onPressed: ref.read(queryProvider.notifier).clearTags,
              child: Text(context.L.filters_clearTagsSelection),
            ),
        ],
      ),
    ),
  );
}

void _showTagsSelectionDialog(BuildContext context, WidgetRef ref) async {
  final tags = await ref.read(wStorageProvider.notifier).getTags();
  final query = ref.read(queryProvider);
  if (context.mounted) {
    showDialog(
      context: context,
      builder: (_) => TagsSelectorDialog(
        tags: tags,
        initialValue: query.tags ?? [],
        onConfirm: ref.read(queryProvider.notifier).setTags,
      ),
    );
  }
}

class SearchFilters extends ConsumerWidget {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        _buildState(context, ref),
        spaceHorizontalInGroup,
        _buildStarred(context, ref),
        spaceHorizontalInGroup,
        _buildTags(context, ref),
        spaceHorizontalInGroup,
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
          ? Text('${selection!.length} tags') // TODO translate
          : Row(children: [
              Text(context.L.filters_articleTags),
              const Icon(Icons.expand_more),
            ]),
      selected: hasSelection,
      onSelected: (_) => _showTagsSelectionDialog(context, ref),
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
          ? Text('${selection!.length} domains') // TODO translate
          : Row(children: [
              Text('Domains'), // TODO translate
              const Icon(Icons.expand_more),
            ]),
      selected: hasSelection,
      onSelected: (_) async {
        final selected = await showBottomSheetSelector(
          context: context,
          title: 'Domains', // TODO translate
          entriesBuilder: DB.get().articlesDao.listAllDomains(),
        );
        if (selected != null) {
          ref
              .read(queryProvider.notifier)
              .overrideWith(WQuery(domains: selected.toList()));
        }
      },
      onDeleted:
          hasSelection ? ref.read(queryProvider.notifier).clearDomains : null,
      shape: chipShape,
      elevation: searchWidgetElevation,
    );
  }
}
