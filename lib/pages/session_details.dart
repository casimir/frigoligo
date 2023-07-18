import 'package:flutter/material.dart';
import 'package:frigoligo/wallabag/wallabag.dart';

import '../models/db.dart';

class SessionDetailsPage extends StatelessWidget {
  const SessionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var wallabag = WallabagInstance.get();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session details'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Server'),
            subtitle: Text(wallabag.server),
          ),
          ListTile(
            title: const Text('Client ID'),
            subtitle: Text(wallabag.clientId),
          ),
          ListTile(
            title: const Text('Client secret'),
            subtitle: Text(wallabag.clientSecret),
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
            onPressed: () {
              WallabagInstance.get()
                  .resetTokenData()
                  .then((_) => DB.clear())
                  .then((_) => Navigator.pushNamedAndRemoveUntil(
                      context, '/', (r) => false));
            },
            child: const Text('Reset session'),
          ),
        ],
      ),
    );
  }
}
