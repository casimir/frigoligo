import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../buildcontext_extension.dart';
import '../datetime_extension.dart';
import '../models/db.dart';
import '../providers/settings.dart';
import '../server/providers/client.dart';
import '../wallabag/credentials.dart';
import '../wallabag/wallabag.dart';

Widget _copyText(BuildContext context, String text, [bool obfuscate = false]) {
  var content = text;
  if (obfuscate) {
    const showLen = 8;
    final prefix = text.substring(0, showLen);
    final suffix = text.substring(text.length - showLen);
    content = '$prefix...$suffix';
  }
  return InkWell(
    onTap: () async {
      await Clipboard.setData(ClipboardData(text: text));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.L.session_copiedToClipboard)));
      }
    },
    child: Text(content, style: const TextStyle(fontFamily: 'monospace')),
  );
}

class SessionDetailsPage extends ConsumerWidget {
  const SessionDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.L.session_title),
      ),
      body: ref.watch(sessionProvider).when(
            data: (it) => _buildDetails(context, ref, it!.wallabag!),
            error: (error, _) => ErrorScreen(error: error as Exception),
            loading: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
          ),
    );
  }
}

Widget _buildDetails(
    BuildContext context, WidgetRef ref, Credentials credentials) {
  String sinceLastSync = context.L.session_neverSynced;
  final lastSync =
      ref.watch(settingsProvider.select((it) => it[Sk.lastRefresh]));
  if (lastSync > 0) {
    sinceLastSync = DateTime.fromMillisecondsSinceEpoch(lastSync * 1000)
        .toHumanizedString(context);
  }

  return ListView(
    children: _buildWallabagSession(context, credentials) +
        [
          ListTile(
            title: Text(context.L.session_fieldLastServerSync),
            subtitle: Text(sinceLastSync),
          ),
          C.spacers.verticalContent,
          ElevatedButton.icon(
            onPressed: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: context.L.session_logoutDialogTitle,
                message: context.L.session_logoutDialogMessage,
                okLabel: context.L.session_logoutDialogConfirm,
                isDestructiveAction: true,
              );
              if (result == OkCancelResult.cancel) return;

              await ref.read(sessionProvider.notifier).logout();
              await ref.read(settingsProvider.notifier).clear();
              await DB.clear();
              if (context.mounted) {
                context.go('/login');
              }
            },
            icon: const Icon(Icons.logout),
            label: Text(context.L.session_logoutSession),
          ),
          C.spacers.verticalContent,
          ElevatedButton.icon(
            onPressed: () async {
              final client = await ref.read(clientProvider.future);
              if (client is WallabagNativeClient) {
                await client.refreshToken();
              }
            },
            icon: const Icon(Icons.restart_alt),
            label: Text(context.L.session_forceTokenResfresh),
          ),
        ],
  );
}

List<Widget> _buildWallabagSession(
  BuildContext context,
  Credentials credentials,
) {
  final token = credentials.token;
  final accessToken = token?.accessToken;
  final nextTokenExpiration =
      token?.expirationDateTime.toHumanizedString(context) ??
          context.L.session_invalidToken;

  return [
    ListTile(
      title: Text(context.L.g_server),
      subtitle: _copyText(context, credentials.server.toString()),
    ),
    ListTile(
      title: Text(context.L.login_fieldClientId),
      subtitle: _copyText(context, credentials.clientId, true),
    ),
    ListTile(
      title: Text(context.L.login_fieldClientSecret),
      subtitle: _copyText(context, credentials.clientSecret, true),
    ),
    ListTile(
      title: Text(context.L.session_fieldAccessToken),
      subtitle: _copyText(context, accessToken.toString(), accessToken != null),
    ),
    ListTile(
      title: Text(context.L.session_fieldTokenExpiration),
      subtitle: Text(nextTokenExpiration),
    ),
  ];
}
