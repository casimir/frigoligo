import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../providers/query.dart';
import '../services/wallabag_storage.dart';
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

class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = context.watch<WallabagStorage>();
    final queryProvider = context.watch<QueryProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFilterHeader(context, context.L.filters_articleState),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(context.L
                  .filters_articlesCount(storage.count(queryProvider.query))),
            ),
          ],
        ),
        _buildFilterChoices(_buildStateFilterChoices(context, queryProvider)),
        _buildFilterHeader(context, context.L.filters_articleFavorite),
        _buildFilterChoices(_buildStarredFilterChoices(context, queryProvider)),
        _buildFilterHeader(context, context.L.filters_articleTags),
        _buildTagsSelector(context, queryProvider, storage.tags),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
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

List<ChoiceChip> _buildStateFilterChoices(
    BuildContext context, QueryProvider queryProvider) {
  final labels = {
    StateFilter.unread: context.L.filters_articleStateUnread,
    StateFilter.archived: context.L.filters_articleStateArchived,
    StateFilter.all: context.L.filters_articleStateAll,
  };

  return List.generate(
    StateFilter.values.length,
    (index) => _makeChoiceChip(
      StateFilter.values[index],
      labels[StateFilter.values[index]]!,
      queryProvider.query.state,
      (selected) {
        if (selected) {
          var wq = queryProvider.query.dup();
          wq.state = StateFilter.values[index];
          queryProvider.query = wq;
        }
      },
    ),
  );
}

List<ChoiceChip> _buildStarredFilterChoices(
    BuildContext context, QueryProvider queryProvider) {
  void Function(bool) onSelected(StarredFilter value) {
    return (selected) {
      if (!selected) return;
      var wq = queryProvider.query.dup();
      wq.starred = value;
      queryProvider.query = wq;
    };
  }

  return [
    _makeChoiceChip(
      StarredFilter.all,
      context.L.filters_articleFavoriteAll,
      queryProvider.query.starred ?? StarredFilter.all,
      onSelected(StarredFilter.all),
    ),
    _makeChoiceChip(
      StarredFilter.starred,
      context.L.filters_articleFavoriteStarred,
      queryProvider.query.starred,
      onSelected(StarredFilter.starred),
    ),
  ];
}

Widget _buildTagsSelector(
    BuildContext context, QueryProvider queryProvider, List<String> tags) {
  final selection = queryProvider.query.tags?.isNotEmpty ?? false
      ? TagList(
          tags: queryProvider.query.tags!,
          onTagPressed: (_) =>
              _showTagsSelectionDialog(context, queryProvider, tags),
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
            onTap: () => _showTagsSelectionDialog(context, queryProvider, tags),
          ),
          if (queryProvider.query.tags?.isNotEmpty ?? false)
            TextButton(
              onPressed: queryProvider.clearTags,
              child: Text(context.L.filters_clearTagsSelection),
            ),
        ],
      ),
    ),
  );
}

void _showTagsSelectionDialog(
    BuildContext context, QueryProvider queryProvider, List<String> tags) {
  showDialog(
    context: context,
    builder: (ctx) => TagsSelectorDialog(
      tags: tags,
      initialValue: queryProvider.query.tags ?? [],
      onConfirm: queryProvider.setTags,
    ),
  );
}
