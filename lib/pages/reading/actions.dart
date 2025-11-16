import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/flows/confirmation_modal.dart';
import 'package:cadanse/components/widgets/adaptive/actions_menu.dart';
import 'package:cadanse/components/widgets/adaptive/buttons.dart';
import 'package:cadanse/components/widgets/adaptive/modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../buildcontext_extension.dart';
import '../../constants.dart';
import '../../data/services/local/storage/database/extensions/article.dart';
import '../../data/services/local/storage/database/models/article.drift.dart';
import '../../services/remote_sync.dart';
import '../../services/remote_sync_actions.dart';
import '../../widget_keys.dart';
import '../reading_settings_configurator.dart';
import 'article_sheet.dart';

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
  Article? article,
  bool withExpander,
) {
  if (article == null) return [];

  final popupMenuKey = GlobalKey();

  final Map<ArticleActionKey, ArticleAction> actions = {
    ArticleActionKey.archive: ArticleAction(
      icon: stateIcons[article.stateValue]!.icon!,
      label:
          article.archivedAt == null
              ? context.L.article_archive
              : context.L.article_unarchive,
      onPressed: () async {
        final syncer = ref.read(remoteSyncerProvider.notifier);
        await syncer.add(
          EditArticleAction(article.id, archived: article.archivedAt == null),
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
          message: article.title,
          action: ConfirmationAction(
            title: context.L.g_delete,
            isDestructive: true,
          ),
        );

        if (!confirmed) return;
        final syncer = ref.read(remoteSyncerProvider.notifier);
        await syncer.add(DeleteArticleAction(article.id));
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
            builder: (_) => const Material(child: ArticleSheet()),
          ),
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
            text: article.url,
            subject: article.title,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
          ),
        );
      },
    ),
    ArticleActionKey.star: ArticleAction(
      icon: starredIcons[article.starredValue]!.icon!,
      label:
          article.starredAt == null
              ? context.L.article_star
              : context.L.article_unstar,
      onPressed: () async {
        final syncer = ref.read(remoteSyncerProvider.notifier);
        await syncer.add(
          EditArticleAction(article.id, starred: article.starredAt == null),
        );
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
