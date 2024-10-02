import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:cadanse/components/widgets/error.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';

import '../buildcontext_extension.dart';

class SelectorBottomSheet extends StatelessWidget {
  const SelectorBottomSheet({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        C.spacers.verticalComponent,
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(title),
          centerTitle: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          primary: false,
        ),
        ...children
      ],
    );
  }
}

class MultiSelect<T> extends StatefulWidget {
  const MultiSelect({
    super.key,
    required this.title,
    required this.selectionLabelizer,
    required this.entries,
    this.initialSelection,
    this.onConfirm,
  });

  final String title;
  final SelectionLabelizer selectionLabelizer;
  final List<DropdownMenuEntry<T>> entries;
  final Set<T>? initialSelection;
  final void Function(Iterable<T>)? onConfirm;

  @override
  State<MultiSelect<T>> createState() => _MultiSelectState<T>();
}

class _MultiSelectState<T> extends State<MultiSelect<T>> {
  late final Map<String, DropdownMenuEntry<T>> _index;
  late final Set<T> _selected;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _index = {for (final it in widget.entries) it.label: it};
    _selected = widget.initialSelection ?? {};
  }

  @override
  Widget build(BuildContext context) => _buildChild(context);
  // Dialog.fullscreen(child: _buildChild(context));

  Widget _buildChild(BuildContext context) {
    return SelectorBottomSheet(
      title: widget.title,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kSpacingBetweenGroups),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.search),
                  hintText: context.L.g_search,
                  border: InputBorder.none,
                ),
                onChanged: (_) => setState(() {}),
                autocorrect: false,
              ),
            ),
            C.spacers.horizontalComponent,
            IconButton(
                icon: const Icon(Icons.restart_alt),
                onPressed: () {
                  _selected.clear();
                  _searchController.clear();
                  setState(() {});
                })
          ]),
        ),
        const Divider(),
        Expanded(
          child: ListView(
              children: search(_searchController.text, _index.keys.toList())
                  .map((m) => _buildItem(context, _index[m.entry]!))
                  .toList()),
        ),
        C.spacers.verticalComponent,
        PaddedGroup(
          child: Row(children: [
            Expanded(
              child: FilledButton(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(context.L.selector_selectbuttonlabel(
                      widget.selectionLabelizer(_selected.length))),
                ),
                onPressed: () {
                  widget.onConfirm?.call(_selected);
                  Navigator.of(context).pop(_selected);
                },
              ),
            ),
          ]),
        ),
        C.spacers.verticalComponent,
      ],
    );
  }

  Widget _buildItem(BuildContext context, DropdownMenuEntry<T> entry) {
    final isSelected = _selected.contains(entry.value);
    return ListTile(
      leading: entry.leadingIcon,
      title: Text(entry.label),
      onTap: () {
        if (_selected.contains(entry.value)) {
          _selected.remove(entry.value);
        } else {
          _selected.add(entry.value);
        }
        setState(() {});
      },
      trailing: isSelected ? const Icon(Icons.check) : const SizedBox(),
      iconColor: isSelected ? Theme.of(context).colorScheme.primary : null,
      textColor: isSelected ? Theme.of(context).colorScheme.primary : null,
    );
  }
}

/// A function that returns a label for the number of selected items.
typedef SelectionLabelizer = String Function(int);

class EntryScore {
  EntryScore(this.entry, this.score);

  final String entry;
  final double score;

  @override
  String toString() => '$entry ($score)';
}

List<EntryScore> search(String query, List<String> entries) {
  if (query.isEmpty) {
    return entries.map((e) => EntryScore(e, 0.0)).toList()
      ..sort((a, b) => a.entry.compareTo(b.entry));
  }

  final preparedQuery =
      query.split(RegExp(r'\s+')).map((e) => '($e)').join('.*');
  final re = RegExp(preparedQuery, caseSensitive: false);
  return entries
      .map((e) => EntryScore(e, _computeScore(re.allMatches(e))))
      .where((e) => e.score > 0.0)
      .toList()
    ..sort((a, b) {
      final delta = b.score.compareTo(a.score);
      return delta == 0 ? a.entry.compareTo(b.entry) : delta;
    });
}

double _computeScore(Iterable<RegExpMatch> matches) {
  if (matches.isEmpty) return 0;

  final start = matches.first.start;
  final end = matches.last.end;
  return 100 / (1 + end - start);
}

Future<Iterable<T>?> showBottomSheetSelector<T>({
  required BuildContext context,
  required String title,
  required SelectionLabelizer selectionLabelizer,
  required Future<Iterable<T>> entriesBuilder,
  Icon? leadingIcon,
  Set<T>? initialSelection,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (_) => FutureBuilder(
        future: entriesBuilder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            // TODO center vertically
            return Center(child: ErrorScreen(error: snapshot.error!));
          }

          return MultiSelect(
            title: title,
            selectionLabelizer: selectionLabelizer,
            entries: snapshot.data!
                .map((it) => DropdownMenuEntry(
                      value: it,
                      label: it.toString(),
                      leadingIcon: leadingIcon,
                    ))
                .toList(),
            initialSelection: initialSelection,
          );
        }),
    backgroundColor: Theme.of(context).colorScheme.surface,
    isScrollControlled: true,
    useSafeArea: true,
  );
}

class SelectorChip<T> extends StatelessWidget {
  const SelectorChip({
    super.key,
    required this.selection,
    required this.onTap,
    required this.onDeleted,
    required this.labelizer,
  });

  final List<T>? selection;
  final void Function() onTap;
  final void Function() onDeleted;
  final SelectionLabelizer labelizer;

  @override
  Widget build(BuildContext context) {
    final hasSelection = selection?.isNotEmpty ?? false;
    return FilterChip(
      label: Text(labelizer(selection?.length ?? 0)),
      selected: hasSelection,
      onSelected: (_) => onTap(),
      deleteIcon: hasSelection ? null : const Icon(Icons.arrow_drop_down),
      deleteButtonTooltipMessage: hasSelection ? null : '',
      onDeleted: hasSelection ? onDeleted : onTap,
    );
  }
}

class Select<T> extends StatelessWidget {
  const Select({
    super.key,
    required this.title,
    required this.entries,
    this.initial,
  });

  final String title;
  final List<DropdownMenuEntry<T>> entries;
  final T? initial;

  @override
  Widget build(BuildContext context) {
    Widget buildItem(DropdownMenuEntry<T> entry) {
      final isSelected = entry.value == initial;
      return ListTile(
        leading: entry.leadingIcon,
        title: Text(entry.label),
        onTap: () => Navigator.of(context).pop(entry.value),
        trailing: isSelected ? const Icon(Icons.check) : const SizedBox(),
        iconColor: isSelected ? Theme.of(context).colorScheme.primary : null,
        textColor: isSelected ? Theme.of(context).colorScheme.primary : null,
      );
    }

    return SelectorBottomSheet(
      title: title,
      children: [
        const Divider(),
        ListView(
          shrinkWrap: true,
          children: entries.map(buildItem).toList(),
        ),
      ],
    );
  }
}

typedef SelectBuilder = Select Function(BuildContext context);

Future<T?> showBottomSheetSelect<T>(
    {required BuildContext context, required SelectBuilder builder}) {
  return showModalBottomSheet(
    context: context,
    builder: builder,
    backgroundColor: Theme.of(context).colorScheme.surface,
  );
}
