import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../providers/query.dart';
import '../services/remote_sync.dart';
import '../widget_keys.dart';
import '../widgets/tag_list.dart';
import 'tags_selector/dialog.dart';

const defaultPadding = 10.0;
const defaultSpacing = 16.0;
const leftAlignedInsets = EdgeInsets.only(
  left: defaultSpacing,
  top: defaultPadding,
  right: defaultPadding,
  bottom: defaultPadding,
);

class FiltersPage extends ConsumerWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.watch(storageProvider);
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
        _buildTagsSelector(context, ref, storage.tags),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}

Widget _buildCount(BuildContext context, int count) {
  final widget = Padding(
    key: const ValueKey(wkListingFiltersCount),
    padding: const EdgeInsets.only(right: 8.0),
    child: Text(context.L.filters_articlesCount(count)),
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

Widget _buildTagsSelector(
    BuildContext context, WidgetRef ref, List<String> tags) {
  final query = ref.watch(queryProvider);
  final selection = query.tags?.isNotEmpty ?? false
      ? TagList(
          tags: query.tags!,
          onTagPressed: (_) => _showTagsSelectionDialog(context, ref, tags),
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
            onTap: () => _showTagsSelectionDialog(context, ref, tags),
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

void _showTagsSelectionDialog(
    BuildContext context, WidgetRef ref, List<String> tags) {
  final query = ref.read(queryProvider);
  showDialog(
    context: context,
    builder: (ctx) => TagsSelectorDialog(
      tags: tags,
      initialValue: query.tags ?? [],
      onConfirm: ref.read(queryProvider.notifier).setTags,
    ),
  );
}
