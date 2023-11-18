import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../providers/query.dart';

class TagsSelectorDialog extends StatelessWidget {
  const TagsSelectorDialog({
    super.key,
    required this.tags,
    required this.queryProvider,
    this.onConfirm,
  });

  final List<String> tags;
  final QueryProvider queryProvider;
  final void Function(List<String>)? onConfirm;

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialog(
      items: tags.map((it) => MultiSelectItem(it, it)).toList(),
      initialValue: queryProvider.query.tags ?? List<String>.empty(),
      title: const Text('Tags'),
      onConfirm: onConfirm ?? queryProvider.setTags,
      searchable: true,
    );
  }
}
