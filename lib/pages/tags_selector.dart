import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class TagsSelectorDialog extends StatelessWidget {
  const TagsSelectorDialog({
    super.key,
    required this.tags,
    this.initialValue = const [],
    required this.onConfirm,
  });

  final List<String> tags;
  final List<String> initialValue;
  final void Function(List<String>) onConfirm;

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialog(
      items: tags.map((it) => MultiSelectItem(it, it)).toList(),
      initialValue: initialValue,
      title: const Text('Tags'),
      onConfirm: onConfirm,
      searchable: true,
    );
  }
}
