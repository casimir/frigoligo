import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:frigoligo/wallabag/wallabag.dart';
import 'package:provider/provider.dart';

import '../models/db.dart';
import '../providers/settings.dart';

class SessionDetailsPage extends StatelessWidget {
  const SessionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsProvider>();
    final wallabag = WallabagInstance.get();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session details'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Server'),
            subtitle: Text(wallabag.connectionData.server),
          ),
          ListTile(
            title: const Text('Client ID'),
            subtitle: Text(wallabag.connectionData.clientId),
          ),
          ListTile(
            title: const Text('Client secret'),
            subtitle: Text(wallabag.connectionData.clientSecret),
          ),
          ListTile(
            title: const Text('Token data'),
            subtitle: Text(
              wallabag.tokenData != null
                  ? wallabag.tokenData!.toJson().toString()
                  : 'none',
            ),
          ),
          ElevatedButton(
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
            child: const Text('Log out session'),
          ),
        ],
      ),
    );
  }
}
