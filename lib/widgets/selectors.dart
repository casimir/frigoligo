import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';

import '../buildcontext_extension.dart';

class MultiSelect<T> extends StatefulWidget {
  const MultiSelect({
    super.key,
    required this.title,
    required this.entries,
    this.initialSelection,
    this.onConfirm,
  });

  final String title;
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
  Widget build(BuildContext context) =>
      Dialog.fullscreen(child: _buildChild(context));

  Widget _buildChild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title),
        actions: [
          TextButton(
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
            onPressed: () {
              widget.onConfirm?.call(_selected);
              Navigator.of(context).pop(_selected);
            },
          )
        ],
      ),
      body: PaddedGroup(
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search),
                    hintText: context.L.g_search,
                  ),
                  onChanged: (_) => setState(() {}),
                  autocorrect: false,
                ),
              ),
              C.spacers.horizontalComponent,
              IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    _selected.clear();
                    _searchController.clear();
                    setState(() {});
                  })
            ]),
            C.spacers.verticalComponent,
            Expanded(
              child: ListView(
                  children: search(_searchController.text, _index.keys.toList())
                      .map((m) => _buildItem(context, _index[m.entry]!))
                      .toList()),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, DropdownMenuEntry<T> entry) {
    final isSelected = _selected.contains(entry.value);
    return ListTile(
      title: Text(entry.label),
      leading: entry.leadingIcon,
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
  required Future<Iterable<T>> entriesBuilder,
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
            entries: snapshot.data!
                .map((it) => DropdownMenuEntry(value: it, label: it.toString()))
                .toList(),
            initialSelection: initialSelection,
          );
        }),
    isScrollControlled: true,
    useSafeArea: true,
  );
}
