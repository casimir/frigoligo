import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../db/extensions/article.dart';
import '../../db/models/article.drift.dart';
import '../../services/remote_sync.dart';
import '../../services/remote_sync_actions/articles.dart';
import '../../widget_keys.dart';
import '../reading_settings_configurator.dart';

enum ArticleActionKey {
  archive,
  delete,
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

  IconButton toIconButton() => IconButton(
        key: key,
        icon: Icon(icon),
        tooltip: label,
        onPressed: onPressed,
      );

  ListTile toListTile() => ListTile(
        leading: Icon(icon),
        title: Text(label),
      );
}

List<Widget> buildActions(
  BuildContext context,
  WidgetRef ref,
  Article? article,
  bool withExpander,
) {
  if (article == null) return [];

  final popupMenuKey = GlobalKey();

  final Map<ArticleActionKey, ArticleAction> actions = {
    ArticleActionKey.archive: ArticleAction(
      icon: stateIcons[article.stateValue]!.icon!,
      label: article.archivedAt == null
          ? context.L.article_archive
          : context.L.article_unarchive,
      onPressed: () async {
        final syncer = ref.read(remoteSyncerProvider.notifier);
        await syncer.add(EditArticleAction(
          article.id,
          archive: article.archivedAt == null,
        ));
        await syncer.synchronize();
      },
    ),
    ArticleActionKey.delete: ArticleAction(
      icon: Icons.delete,
      label: context.L.article_delete,
      onPressed: () async {
        final result = await showOkCancelAlertDialog(
          context: context,
          title: context.L.article_delete,
          message: article.title,
          okLabel: context.L.g_delete,
          isDestructiveAction: true,
        );
        if (result == OkCancelResult.cancel) return;
        final syncer = ref.read(remoteSyncerProvider.notifier);
        await syncer.add(DeleteArticleAction(article.id));
        await syncer.synchronize();
        if (!withExpander && context.mounted) {
          context.go('/');
        }
      },
      isDestructive: true,
    ),
    ArticleActionKey.openInBrowser: ArticleAction(
      icon: Icons.open_in_browser,
      label: context.L.article_openInBrowser,
      onPressed: () => launchUrl(Uri.parse(article.url)),
    ),
    ArticleActionKey.readingSettings: ArticleAction(
      icon: Icons.format_size,
      label: context.L.article_readingSettings,
      key: const Key(wkArticleReadingSettings),
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (_) => const ReadingSettingsConfigurator(),
        barrierColor: Colors.transparent,
        showDragHandle: true,
      ),
    ),
    ArticleActionKey.share: ArticleAction(
      icon: shareIcon.icon!,
      label: context.L.article_share,
      onPressed: () {
        final box =
            popupMenuKey.currentContext!.findRenderObject() as RenderBox?;
        Share.share(
          article.url,
          subject: article.title,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      },
    ),
    ArticleActionKey.star: ArticleAction(
      icon: starredIcons[article.starredValue]!.icon!,
      label: article.starredAt == null
          ? context.L.article_star
          : context.L.article_unstar,
      onPressed: () async {
        final syncer = ref.read(remoteSyncerProvider.notifier);
        await syncer.add(EditArticleAction(
          article.id,
          starred: article.starredAt == null,
        ));
        await syncer.synchronize();
      },
    ),
  };

  final mainActions = [
    ArticleActionKey.archive,
    ArticleActionKey.star,
  ];
  final moreActions = [
    ArticleActionKey.openInBrowser,
    ArticleActionKey.share,
    ArticleActionKey.delete,
    ArticleActionKey.readingSettings,
  ];

  return [
    ...mainActions.map((key) => actions[key]!.toIconButton() as Widget),
    Builder(builder: (context) {
      return IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () => Scaffold.of(context).openEndDrawer(),
      );
    }),
    if (UniversalPlatform.isIOS)
      IconButton(
        key: popupMenuKey,
        icon: const Icon(Icons.more_horiz),
        onPressed: () {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              title: Text(article.title),
              message: Text(article.url),
              actions: moreActions
                  .map((key) => CupertinoActionSheetAction(
                        onPressed: () => actions[key]!.onPressed(),
                        isDestructiveAction: actions[key]!.isDestructive,
                        child: Text(actions[key]!.label),
                      ))
                  .toList(),
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.of(context).pop(),
                child:
                    Text(MaterialLocalizations.of(context).cancelButtonLabel),
              ),
            ),
          );
        },
      )
    else
      PopupMenuButton(
          key: popupMenuKey,
          enableFeedback: true,
          itemBuilder: (context) => moreActions
              .map((key) => PopupMenuItem(
                    value: key,
                    child: actions[key]!.toListTile(),
                    onTap: () => actions[key]!.onPressed(),
                  ))
              .toList()),
  ];
}
