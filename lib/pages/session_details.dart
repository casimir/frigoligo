import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../datetime_extension.dart';
import '../models/db.dart';
import '../providers/settings.dart';
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
            const SnackBar(content: Text('Copied to your clipboard!')));
      }
    },
    child: Text(content, style: const TextStyle(fontFamily: 'monospace')),
  );
}

class SessionDetailsPage extends StatelessWidget {
  const SessionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsProvider>();
    final wallabag = WallabagInstance.get();

    String sinceLastSync = 'never';
    final lastSync = settings[Sk.lastRefresh];
    if (lastSync > 0) {
      sinceLastSync = DateTime.fromMillisecondsSinceEpoch(lastSync * 1000)
          .toHumanizedString();
    }
    final token = wallabag.credentials.token;
    final accessToken = token?.accessToken;
    final nextTokenExpiration =
        token?.expirationDateTime.toHumanizedString() ?? 'invalid';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session details'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Server'),
            subtitle:
                _copyText(context, wallabag.credentials.server.toString()),
          ),
          ListTile(
            title: const Text('Client ID'),
            subtitle: _copyText(context, wallabag.credentials.clientId, true),
          ),
          ListTile(
            title: const Text('Client secret'),
            subtitle:
                _copyText(context, wallabag.credentials.clientSecret, true),
          ),
          ListTile(
            title: const Text('Access token'),
            subtitle:
                _copyText(context, accessToken.toString(), accessToken != null),
          ),
          ListTile(
            title: const Text('Token expiration'),
            subtitle: Text(nextTokenExpiration),
          ),
          ListTile(
            title: const Text('Last server sync'),
            subtitle: Text(sinceLastSync),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Log out session',
                message: 'You will need to log in again.',
                okLabel: 'Log out',
                isDestructiveAction: true,
              );
              if (result == OkCancelResult.cancel) return;

              await WallabagInstance.get().resetTokenData();
              settings.clear();
              await DB.clear();
              if (context.mounted) {
                context.go('/login');
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('Log out session'),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () => WallabagInstance.get().refreshToken(),
            icon: const Icon(Icons.restart_alt),
            label: const Text('Force token refresh'),
          ),
        ],
      ),
    );
  }
}
