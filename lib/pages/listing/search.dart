import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../db/database.dart';
import '../../providers/query.dart';
import '../../services/wallabag_storage.dart';
import '../../widgets/chip_filter_menu.dart';
import '../../widgets/selectors.dart';
import '../tags_selector/dialog.dart';

const defaultPadding = 10.0;
const defaultSpacing = 16.0;
const leftAlignedInsets = EdgeInsets.only(
  left: defaultSpacing,
  top: defaultPadding,
  right: defaultPadding,
  bottom: defaultPadding,
);
// TODO move to cadanse
const spaceHorizontalInGroup = SizedBox(width: 8.0);

final chipShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0));
const searchWidgetElevation = 6.0;

// TODO clean translatable strings
void _toClean(BuildContext context) {
  context.L.filters_articleFavorite;
  context.L.filters_articleFavoriteAll;
  context.L.filters_articleFavoriteStarred;
  context.L.filters_articleState;
  context.L.filters_articleStateAll;
  context.L.filters_articleStateArchived;
  context.L.filters_articleStateUnread;
  context.L.filters_articleTags;
  context.L.filters_articlesCount(1);
  context.L.filters_clearTagsSelection;
  context.L.filters_noTagsSelected;
}

void _showTagsSelectionDialog(BuildContext context, WidgetRef ref) async {
  final tags = await ref.read(wStorageProvider.notifier).getTags();
  final query = ref.read(queryProvider);
  if (context.mounted) {
    showDialog(
      context: context,
      builder: (_) => TagsSelectorDialog(
        tags: tags,
        initialValue: query.tags ?? [],
        onConfirm: ref.read(queryProvider.notifier).setTags,
      ),
    );
  }
}

class SearchFilters extends ConsumerWidget {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        _buildState(context, ref),
        spaceHorizontalInGroup,
        _buildStarred(context, ref),
        spaceHorizontalInGroup,
        _buildTags(context, ref),
        spaceHorizontalInGroup,
        _buildDomains(context, ref),
      ]),
    );
  }

  Widget _buildState(BuildContext context, WidgetRef ref) {
    final entries = [
      DropdownMenuEntry(
        value: StateFilter.unread,
        label: context.L.filters_articleStateUnread,
        leadingIcon: const Icon(Icons.inbox),
      ),
      DropdownMenuEntry(
        value: StateFilter.archived,
        label: context.L.filters_articleStateArchived,
        leadingIcon: const Icon(Icons.archive),
      ),
      DropdownMenuEntry(
        value: StateFilter.all,
        label: context.L.filters_articleStateAll,
        leadingIcon: const Icon(Icons.filter_none),
      ),
    ];
    return ChipFilterMenu(
      initialSelection: StateFilter.all,
      onSelected: (entry) => ref
          .read(queryProvider.notifier)
          .overrideWith(WQuery(state: entry.value)),
      entries: entries,
      value: ref.watch(queryProvider.select((q) => q.state)),
      chipShape: chipShape,
      chipElevation: searchWidgetElevation,
    );
  }

  Widget _buildStarred(BuildContext context, WidgetRef ref) {
    return FilterChip.elevated(
      label: Text(context.L.filters_articleFavoriteStarred),
      selected: ref.watch(
          queryProvider.select((q) => q.starred == StarredFilter.starred)),
      onSelected: (value) => ref.read(queryProvider.notifier).overrideWith(
          WQuery(starred: value ? StarredFilter.starred : StarredFilter.all)),
      shape: chipShape,
      elevation: searchWidgetElevation,
    );
  }

  Widget _buildTags(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(queryProvider.select((q) => q.tags));
    final hasSelection = selection?.isNotEmpty ?? false;
    return FilterChip.elevated(
      label: hasSelection
          ? Text('${selection!.length} tags') // TODO translate
          : Row(children: [
              Text(context.L.filters_articleTags),
              const Icon(Icons.expand_more),
            ]),
      selected: hasSelection,
      onSelected: (_) => _showTagsSelectionDialog(context, ref),
      onDeleted:
          hasSelection ? ref.read(queryProvider.notifier).clearTags : null,
      shape: chipShape,
      elevation: searchWidgetElevation,
    );
  }

  Widget _buildDomains(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(queryProvider.select((q) => q.domains));
    final hasSelection = selection?.isNotEmpty ?? false;
    return FilterChip.elevated(
      label: hasSelection
          ? Text('${selection!.length} domains') // TODO translate
          : Row(children: [
              Text('Domains'), // TODO translate
              const Icon(Icons.expand_more),
            ]),
      selected: hasSelection,
      onSelected: (_) async {
        final selected = await showBottomSheetSelector(
          context: context,
          title: 'Domains', // TODO translate
          entriesBuilder: DB.get().articlesDao.listAllDomains(),
          initialSelection: selection?.toSet(),
        );
        if (selected != null) {
          if (selected.isNotEmpty) {
            ref
                .read(queryProvider.notifier)
                .overrideWith(WQuery(domains: selected.toList()));
          } else {
            ref.read(queryProvider.notifier).clearDomains();
          }
        }
      },
      onDeleted:
          hasSelection ? ref.read(queryProvider.notifier).clearDomains : null,
      shape: chipShape,
      elevation: searchWidgetElevation,
    );
  }
}
