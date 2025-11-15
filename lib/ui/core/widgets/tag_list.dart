import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  const TagList({super.key, required this.tags, this.onTagPressed});

  final List<String> tags;
  final void Function(String)? onTagPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: tags.map((tag) => _buildTag(context, tag)).toList(),
    );
  }

  ActionChip _buildTag(BuildContext context, String tag) {
    return ActionChip(
      label: Text(tag),
      labelStyle: Theme.of(context).textTheme.labelSmall,
      onPressed: () => onTagPressed?.call(tag),
      padding: const EdgeInsets.all(2.0),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }
}
