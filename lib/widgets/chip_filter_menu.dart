import 'package:flutter/material.dart';

class ChipFilterMenu<T> extends StatefulWidget {
  const ChipFilterMenu({
    super.key,
    required this.initialSelection,
    this.onSelected,
    this.value,
    required this.entries,
  });

  final T initialSelection;
  final void Function(DropdownMenuEntry<T>)? onSelected;
  final T? value;
  final List<DropdownMenuEntry<T>> entries;

  @override
  State<ChipFilterMenu<T>> createState() => _ChipFilterMenuState<T>();
}

class _ChipFilterMenuState<T> extends State<ChipFilterMenu<T>> {
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    final lookupValue = widget.value ?? widget.initialSelection;
    final selected = widget.entries.firstWhere((e) => e.value == lookupValue);
    return MenuAnchor(
      controller: _controller,
      menuChildren: widget.entries
          .map((e) => ListTile(
                leading: e.leadingIcon,
                title: Text(e.label),
                onTap: () {
                  widget.onSelected?.call(e);
                  _controller.close();
                },
              ))
          .toList(),
      builder: (context, controller, child) {
        return FilterChip.elevated(
          label: Text(selected.label),
          selected: selected.value != widget.initialSelection,
          onSelected: (_) {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 6.0,
        );
      },
    );
  }
}