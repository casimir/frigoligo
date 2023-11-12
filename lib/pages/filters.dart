import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/query.dart';
import '../services/wallabag_storage.dart';
import '../string_extension.dart';

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
        Card(
          shape: const Border(),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(10.0).copyWith(left: 16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    child: MultiSelectDialogField(
                      items: storage.tags
                          .map((it) => MultiSelectItem(it, it))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        var wq = queryProvider.query.dup();
                        wq.tags = values;
                        queryProvider.query = wq;
                      },
                      buttonText: const Text('Filter by tags'),
                      title: const Text('Tags'),
                      searchable: true,
                      separateSelectedItems: true,
                      initialValue:
                          queryProvider.query.tags ?? List<String>.empty(),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      var wq = queryProvider.query.dup();
                      wq.tags = [];
                      queryProvider.query = wq;
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ]),
              ],
            ),
          ),
        ),
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
    padding: const EdgeInsets.all(10.0).copyWith(left: 16.0),
    child: Text(label, style: filterLabelStyle),
  );
}

Widget _buildFilterChoices(List<Widget> children) {
  return Card(
    shape: const Border(),
    margin: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(10.0).copyWith(left: 16.0),
      child: Wrap(
        spacing: 16.0,
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
      queryProvider.query.starred,
      onSelected(StarredFilter.all),
    ),
    _makeChoiceChip(
      StarredFilter.starred,
      queryProvider.query.starred,
      onSelected(StarredFilter.starred),
    ),
  ];
}
