import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/query.dart';
import '../services/wallabag_storage.dart';
import '../string_extension.dart';
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
            _buildFilterHeader(context, 'State'),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
                  Text('${storage.count(queryProvider.query)} articles found'),
            ),
          ],
        ),
        _buildFilterChoices(_buildStateFilterChoices(queryProvider)),
        _buildFilterHeader(context, 'Favorites'),
        _buildFilterChoices(_buildStarredFilterChoices(queryProvider)),
        _buildFilterHeader(context, 'Tags'),
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
    T value, T? selected, void Function(bool) onSelected) {
  return ChoiceChip(
    label: Text(value.name.toCapitalCase()!),
    onSelected: onSelected,
    selected: value == selected,
    showCheckmark: false,
  );
}

List<ChoiceChip> _buildStateFilterChoices(QueryProvider queryProvider) {
  return List.generate(
    StateFilter.values.length,
    (index) => _makeChoiceChip(
      StateFilter.values[index],
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

List<ChoiceChip> _buildStarredFilterChoices(QueryProvider queryProvider) {
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
      queryProvider.query.starred ?? StarredFilter.all,
      onSelected(StarredFilter.all),
    ),
    _makeChoiceChip(
      StarredFilter.starred,
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
      : const Padding(
          // make the Card at least the same height than the others
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text('No tags selected'),
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
              child: const Text('Clear selection'),
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
