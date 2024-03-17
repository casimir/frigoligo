import 'package:cadanse/layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../buildcontext_extension.dart';

class TagsSelectorDialog extends StatefulWidget {
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
  State<TagsSelectorDialog> createState() => _TagsSelectorDialogState();
}

class _TagsSelectorDialogState extends State<TagsSelectorDialog> {
  final TextEditingController _searchController = TextEditingController();
  Set<String> _selectedTags = {};

  @override
  void initState() {
    super.initState();
    _selectedTags = widget.initialValue.toSet();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // https://docs.flutter.dev/platform-integration/platform-adaptations#alert-dialog
    // https://m3.material.io/components/dialogs/guidelines#9d723c7a-03d1-4e7c-95af-a20ed4b66533
    return AlertDialog(
      scrollable: true,
      content: Column(
        children: [
          Row(children: [Expanded(child: _buildSearchField())]),
          SizedBox(
            width: mediumBreakpoint * 0.66,
            height: MediaQuery.of(context).size.height * 0.66,
            child: ListView(
              children: widget.tags
                  .where((e) => e.contains(_searchController.text))
                  .toList()
                  .map((e) => _buildItem(context, e))
                  .toList(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        TextButton(
          onPressed: () {
            if (!setEquals(widget.initialValue.toSet(), _selectedTags)) {
              widget.onConfirm(_selectedTags.toList());
            }
            Navigator.of(context).pop(true);
          },
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: context.L.g_search,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          onPressed: () => setState(_searchController.clear),
          icon: const Icon(Icons.backspace_outlined),
        ),
      ),
      autocorrect: false,
      onChanged: (value) => setState(() {}),
    );
  }

  Widget _buildItem(BuildContext context, String tag) {
    final isSelected = _selectedTags.contains(tag);
    void toggle([_]) => setState(() {
          if (isSelected) {
            _selectedTags.remove(tag);
          } else {
            _selectedTags.add(tag);
          }
        });
    return ListTile(
      title: Text(tag),
      trailing: Checkbox(value: isSelected, onChanged: toggle),
      iconColor: isSelected ? Theme.of(context).colorScheme.primary : null,
      textColor: isSelected ? Theme.of(context).colorScheme.primary : null,
      onTap: toggle,
    );
  }
}
