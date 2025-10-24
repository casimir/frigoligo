import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/flows/confirmation_modal.dart';
import 'package:cadanse/components/widgets/adaptive/actions_menu.dart';
import 'package:cadanse/components/widgets/adaptive/buttons.dart';
import 'package:cadanse/components/widgets/adaptive/modal_sheet.dart';
import 'package:cadanse/components/widgets/adaptive/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../buildcontext_extension.dart';
import '../../../config/dependencies.dart';
import '../../../constants.dart';
import '../../../domain/models/article_data.dart';
import '../../../pages/reading_settings_configurator.dart';
import '../../../services/remote_sync.dart';
import '../../../services/remote_sync_actions.dart';
import '../../../widget_keys.dart';
import '../../core/widgets/async_value_loader.dart';
import '../../core/widgets/navigation_split_view.dart';
import '../../repository_providers.dart';
import '../controllers/article_sheet_controller.dart';
import '../states.dart';
import 'article_content.dart';
import 'article_content_placeholder.dart';
import 'article_sheet.dart';
import 'reading_progress_indicator.dart';
import 'remote_sync.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  const ArticleScreen({super.key, required this.articleId});

  final int articleId;

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  final ScrollController scroller = ScrollController();

  @override
  void dispose() {
    scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('ArticleScreen build');

    final navigationSplitViewScope = NavigationSplitViewScope.maybeOf(context);
    final isSideBySideExpandedLayout =
        navigationSplitViewScope?.layout ==
            NavigationSplitViewLayout.sideBySide &&
        navigationSplitViewScope?.isContentExpanded == true;
    final withProgressIndicator =
        navigationSplitViewScope == null || isSideBySideExpandedLayout;

    return AsyncValueLoader(
      value: ref.watch(articleExistsStateProvider(widget.articleId)),
      builder: (context, exists) {
        return exists
            ? _buildContent(context, withProgressIndicator)
            : _buildEmpty(context, withProgressIndicator);
      },
    );
  }

  Widget _buildContent(BuildContext context, bool withProgressIndicator) {
    final navigationSplitViewScope = NavigationSplitViewScope.maybeOf(context);
    final isSideBySideLayout =
        navigationSplitViewScope?.layout ==
        NavigationSplitViewLayout.sideBySide;

    return AsyncValueLoader(
      value: ref.watch(articleStateProvider(widget.articleId)),
      builder: (context, data) {
        final List<Widget> actions = buildActions(
          context,
          ref,
          data!,
          isSideBySideLayout,
        );

        return _PageScaffold(
          controller: scroller,
          appBarLeading: const ExpandContentButton(),
          actions: actions,
          withProgressIndicator: withProgressIndicator,
          scrollEnabled: data.hasContent,
          builder:
              (_) =>
                  !data.hasContent
                      ? ArticleContentPlaceholder(
                        articleUrl: Uri.parse(data.url),
                        openUrlCallback: (url) => launchUrl(url),
                      )
                      : ArticleContent(articleId: data.id),
        );
      },
    );
  }

  Widget _buildEmpty(BuildContext context, bool withProgressIndicator) {
    return _PageScaffold(
      appBarLeading: const ExpandContentButton(),
      withProgressIndicator: withProgressIndicator,
      scrollEnabled: false,
      builder: (_) => const Center(child: Icon(Icons.question_mark)),
    );
  }
}

class _PageScaffold extends StatelessWidget {
  const _PageScaffold({
    this.controller,
    required this.appBarLeading,
    this.actions = const [],
    required this.withProgressIndicator,
    this.scrollEnabled = true,
    required this.builder,
  });

  final ScrollController? controller;
  final Widget? appBarLeading;
  final List<Widget> actions;
  final bool withProgressIndicator;
  final bool scrollEnabled;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBarBottom =
        withProgressIndicator
            ? const RemoteSyncProgressIndicator(
              idleWidget: ReadingProgressIndicator(),
            )
            : const ReadingProgressIndicator();

    return AdaptiveScaffold(
      barData: AdaptiveBarData(
        leading: appBarLeading,
        actions: actions,
        bottom: appBarBottom,
      ),
      body: builder(context),
    );
  }
}

enum ArticleActionKey {
  archive,
  delete,
  details,
  openInBrowser,
  readingSettings,
  share,
  star,
}

class ArticleAction {
  const ArticleAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.key,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final void Function() onPressed;
  final Key? key;
  final bool isDestructive;

  ActionButton toActionButton() =>
      ActionButton(key: key, icon: icon, tooltip: label, onPressed: onPressed);

  ListTile toListTile() => ListTile(leading: Icon(icon), title: Text(label));
}

List<Widget> buildActions(
  BuildContext context,
  WidgetRef ref,
  ArticleData data,
  bool withExpander,
) {
  final popupMenuKey = GlobalKey();

  final isStarred = data.isStarred;

  final Map<ArticleActionKey, ArticleAction> actions = {
    ArticleActionKey.archive: ArticleAction(
      icon:
          stateIcons[data.isArchived
                  ? StateFilter.archived
                  : StateFilter.unread]!
              .icon!,
      label:
          data.isArchived
              ? context.L.article_unarchive
              : context.L.article_archive,
      onPressed: () async {
        final syncer = ref.read(remoteSyncerProvider.notifier);
        await syncer.add(
          EditArticleAction(data.id, archived: !data.isArchived),
        );
        await syncer.synchronize();
        if (!withExpander && context.mounted) {
          context.pop();
        }
      },
    ),
    ArticleActionKey.delete: ArticleAction(
      icon: C(context).icons.delete,
      label: context.L.article_delete,
      onPressed: () async {
        final confirmed = await askForConfirmation(
          context: context,
          title: context.L.article_delete,
          message: data.title,
          action: ConfirmationAction(
            title: context.L.g_delete,
            isDestructive: true,
          ),
        );

        if (!confirmed) return;
        final syncer = ref.read(remoteSyncerProvider.notifier);
        await syncer.add(DeleteArticleAction(data.id));
        await syncer.synchronize();
        if (!withExpander && context.mounted) {
          context.go('/');
        }
      },
      isDestructive: true,
    ),
    ArticleActionKey.details: ArticleAction(
      icon: C(context).icons.info,
      label: context.L.article_details,
      onPressed:
          () => showModalSheet(
            context: context,
            title: context.L.g_article,
            builder:
                (_) => Material(
                  child: ArticleSheet(
                    controller: ArticleSheetController(
                      syncer: ref.read(remoteSyncerProvider.notifier),
                      tagRepository: ref.watch(tagRepositoryProvider),
                      sharingService: dependencies.get(),
                      urlLauncherService: dependencies.get(),
                      articleId: data.id,
                    ),
                    data: data,
                  ),
                ),
          ),
    ),
    ArticleActionKey.openInBrowser: ArticleAction(
      icon: Icons.open_in_browser,
      label: context.L.article_openInBrowser,
      onPressed: () => launchUrl(Uri.parse(data.url)),
    ),
    ArticleActionKey.readingSettings: ArticleAction(
      icon: Icons.format_size,
      label: context.L.article_readingSettings,
      key: const Key(wkArticleReadingSettings),
      onPressed:
          () => showModalBottomSheet(
            context: context,
            builder: (_) => const ReadingSettingsConfigurator(),
            barrierColor: Colors.transparent,
          ),
    ),
    ArticleActionKey.share: ArticleAction(
      icon: Icons.adaptive.share,
      label: context.L.article_share,
      onPressed: () {
        final box =
            popupMenuKey.currentContext!.findRenderObject() as RenderBox?;
        SharePlus.instance.share(
          ShareParams(
            text: data.url,
            subject: data.title,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
          ),
        );
      },
    ),
    ArticleActionKey.star: ArticleAction(
      icon:
          starredIcons[isStarred
                  ? StarredFilter.starred
                  : StarredFilter.unstarred]!
              .icon!,
      label: isStarred ? context.L.article_unstar : context.L.article_star,
      onPressed: () async {
        final syncer = ref.read(remoteSyncerProvider.notifier);
        await syncer.add(EditArticleAction(data.id, starred: !isStarred));
        await syncer.synchronize();
      },
    ),
  };

  final mainActions = [
    ArticleActionKey.archive,
    ArticleActionKey.star,
    ArticleActionKey.details,
  ];
  final moreActions = [
    ArticleActionKey.openInBrowser,
    ArticleActionKey.share,
    ArticleActionKey.delete,
    null, // divide article actions from general actions
    ArticleActionKey.readingSettings,
  ];

  return [
    ...mainActions.map((key) => actions[key]!.toActionButton()),
    ActionsMenuButton(
      key: popupMenuKey,
      actions:
          moreActions
              .map(
                (key) =>
                    key != null
                        ? ActionsMenuEntry(
                          title: actions[key]!.label,
                          icon: actions[key]!.icon,
                          onTap: () => actions[key]!.onPressed(),
                          isDestructive: actions[key]!.isDestructive,
                        )
                        : null,
              )
              .toList(),
      // the blur effect doesn't work on top of the native webview
      applyBlurEffect: false,
    ),
  ];
}
