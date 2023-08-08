import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frigoligo/wallabag/wallabag.dart';
import 'package:provider/provider.dart';

import '../models/db.dart';
import '../providers/settings.dart';

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
      await Clipboard.setData(ClipboardData(text: content));
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
      final now = DateTime.now().millisecondsSinceEpoch / 1000;
      final elapsed = now - lastSync;
      if (elapsed < 1000) {
        sinceLastSync = '${elapsed.toStringAsFixed(0)} seconds ago';
      } else {
        final asMinutes = elapsed / 60;
        sinceLastSync = '${asMinutes.toStringAsFixed(0)} minutes ago';
      }
    }
    final accessToken = wallabag.tokenData?.accessToken;
    final accessTokenValidity = wallabag.tokenData != null
        ? wallabag.tokenData!.expiresIn.toIso8601String()
        : 'invalid';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session details'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Server'),
            subtitle:
                _copyText(context, 'https://${wallabag.connectionData.server}'),
          ),
          ListTile(
            title: const Text('Client ID'),
            subtitle:
                _copyText(context, wallabag.connectionData.clientId, true),
          ),
          ListTile(
            title: const Text('Client secret'),
            subtitle:
                _copyText(context, wallabag.connectionData.clientSecret, true),
          ),
          ListTile(
            title: const Text('Access token'),
            subtitle:
                _copyText(context, accessToken.toString(), accessToken != null),
          ),
          ListTile(
            title: const Text('Token valid until'),
            subtitle: Text(accessTokenValidity),
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
              settings.remove(Sk.lastRefresh);
              await DB.clear();
              if (context.mounted) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (r) => false);
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('Log out session'),
          ),
        ],
      ),
    );
  }
}
