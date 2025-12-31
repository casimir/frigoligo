import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/flows/confirmation_modal.dart';
import 'package:cadanse/components/widgets/adaptive/actions_menu.dart';
import 'package:cadanse/components/widgets/adaptive/buttons.dart';
import 'package:cadanse/components/widgets/adaptive/modal_sheet.dart';
import 'package:cadanse/components/widgets/adaptive/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../buildcontext_extension.dart';
import '../../../config/dependencies.dart';
import '../../../constants.dart';
import '../../../domain/models/article_data.dart';
import '../../../domain/managers/sync_manager.dart';
import '../../../pages/reading_settings_configurator.dart';
import '../../../ui/core/states.dart';
import '../../core/states.dart';
import '../../core/widgets/async_value_loader.dart';
import '../../core/widgets/navigation_split_view.dart';
import '../../core/widgets/reading_progress_indicator.dart';
import '../../core/widgets/remote_sync.dart';
import '../../repository_providers.dart';
import '../controllers/article_content_controller.dart';
import '../controllers/article_screen_controller.dart';
import '../controllers/article_sheet_controller.dart';
import 'article_content.dart';
import 'article_content_placeholder.dart';
import 'article_sheet.dart';

export 'article_content.dart' show ContentBuilder;

class ArticleScreen extends ConsumerStatefulWidget {
  const ArticleScreen({
    super.key,
    required this.controller,
    this.contentBuilder,
  });

  final ArticleScreenController controller;
  final ContentBuilder? contentBuilder;

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  final ScrollController scroller = ScrollController();

  bool get _isSideBySideLayout =>
      NavigationSplitViewScope.maybeOf(context)?.layout ==
      NavigationSplitViewLayout.sideBySide;

  @override
  void dispose() {
    scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationSplitViewScope = NavigationSplitViewScope.maybeOf(context);
    final isSideBySideExpandedLayout =
        _isSideBySideLayout &&
        navigationSplitViewScope?.isContentExpanded == true;
    final withProgressIndicator =
        navigationSplitViewScope == null || isSideBySideExpandedLayout;

    return AsyncValueLoader(
      value: ref.watch(articleExistsStateProvider(widget.controller.articleId)),
      builder: (context, exists) {
        return exists
            ? _buildContent(context, withProgressIndicator)
            : _buildEmpty(context, withProgressIndicator);
      },
    );
  }

  Widget _buildContent(BuildContext context, bool withProgressIndicator) {
    return AsyncValueLoader(
      value: ref.watch(articleStateProvider(widget.controller.articleId)),
      builder: (context, data) {
        final List<Widget> actions = buildActions(
          widget.controller,
          context,
          ref,
          data!,
          _isSideBySideLayout,
        );

        return _PageScaffold(
          controller: scroller,
          appBarLeading: const ExpandContentButton(),
          actions: actions,
          withProgressIndicator: withProgressIndicator,
          scrollEnabled: data.hasContent,
          builder: (_) => !data.hasContent
              ? ArticleContentPlaceholder(
                  articleUrl: Uri.parse(data.url),
                  openUrlCallback: (url) =>
                      widget.controller.openInBrowser(url),
                )
              : ArticleContent(
                  controller: ArticleContentController(
                    articleRepository: ref.watch(articleRepositoryProvider),
                    articleId: data.id,
                  ),
                  contentBuilder: widget.contentBuilder,
                ),
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
    final PreferredSizeWidget appBarBottom = withProgressIndicator
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
    this.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
  });

  final Key? key;
  final IconData icon;
  final String label;
  final void Function() onPressed;
  final bool isDestructive;

  ActionButton toActionButton() =>
      ActionButton(key: key, icon: icon, tooltip: label, onPressed: onPressed);
}

const kArticleActionArchive = Key('article.actions.archive');
const kArticleActionDelete = Key('article.actions.delete');
const kArticleActionDetails = Key('article.actions.details');
const kArticleActionOpenInBrowser = Key('article.actions.openInBrowser');
const kArticleActionReadingSettings = Key('article.actions.readingSettings');
const kArticleActionShare = Key('article.actions.share');
const kArticleActionStar = Key('article.actions.star');

List<Widget> buildActions(
  ArticleScreenController controller,
  BuildContext context,
  WidgetRef ref,
  ArticleData data,
  bool withExpander,
) {
  final popupMenuKey = GlobalKey();

  final isStarred = data.isStarred;

  final Map<ArticleActionKey, ArticleAction> actions = {
    ArticleActionKey.archive: ArticleAction(
      key: kArticleActionArchive,
      icon:
          stateIcons[data.isArchived
                  ? StateFilter.archived
                  : StateFilter.unread]!
              .icon!,
      label: data.isArchived
          ? context.L.article_unarchive
          : context.L.article_archive,
      onPressed: () async {
        await controller.setArchived(!data.isArchived);
        if (!withExpander && context.mounted) {
          Navigator.of(context).pop();
        }
      },
    ),
    ArticleActionKey.delete: ArticleAction(
      key: kArticleActionDelete,
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
        await controller.deleteArticle();
        if (!withExpander && context.mounted) {
          context.go('/');
        }
      },
      isDestructive: true,
    ),
    ArticleActionKey.details: ArticleAction(
      key: kArticleActionDetails,
      icon: C(context).icons.info,
      label: context.L.article_details,
      onPressed: () => showModalSheet(
        context: context,
        title: context.L.g_article,
        builder: (_) => Material(
          child: ArticleSheet(
            controller: ArticleSheetController(
              syncManager: SyncManager.instance,
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
      key: kArticleActionOpenInBrowser,
      icon: Icons.open_in_browser,
      label: context.L.article_openInBrowser,
      onPressed: () => controller.openInBrowser(Uri.parse(data.url)),
    ),
    ArticleActionKey.readingSettings: ArticleAction(
      key: kArticleActionReadingSettings,
      icon: Icons.format_size,
      label: context.L.article_readingSettings,
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (_) => const ReadingSettingsConfigurator(),
        barrierColor: Colors.transparent,
      ),
    ),
    ArticleActionKey.share: ArticleAction(
      key: kArticleActionShare,
      icon: Icons.adaptive.share,
      label: context.L.article_share,
      onPressed: () {
        final box =
            popupMenuKey.currentContext!.findRenderObject() as RenderBox;
        final sharePositionOrigin = box.localToGlobal(Offset.zero) & box.size;
        controller.shareArticle(data.title, data.url, sharePositionOrigin);
      },
    ),
    ArticleActionKey.star: ArticleAction(
      key: kArticleActionStar,
      icon:
          starredIcons[isStarred
                  ? StarredFilter.starred
                  : StarredFilter.unstarred]!
              .icon!,
      label: isStarred ? context.L.article_unstar : context.L.article_star,
      onPressed: () async {
        await controller.setStarred(!isStarred);
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
      actions: moreActions
          .map(
            (key) => key != null
                ? ActionsMenuEntry(
                    key: actions[key]!.key,
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
