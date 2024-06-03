import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../buildcontext_extension.dart';
import '../models/db.dart';
import '../providers/server_login_flow.dart';
import '../providers/settings.dart';
import '../wallabag/wallabag.dart';
import 'login_flow/check_server.dart';
import 'login_flow/login_wallabag.dart';
import 'login_flow/utils.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key, this.initial});

  final Map<String, String>? initial;

  bool get hasInitialData => initial != null && initial!.isNotEmpty;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late Map<String, String>? _currentData;
  bool _hasBeenReset = false;

  @override
  void initState() {
    super.initState();

    // use server-level data if already configured
    final wallabag = WallabagInstance.get();
    if (!widget.hasInitialData && wallabag.hasCredentials) {
      _currentData = {
        'server': wallabag.credentials.server.toString(),
        'clientId': wallabag.credentials.clientId,
        'clientSecret': wallabag.credentials.clientSecret,
      };
    } else {
      _currentData = widget.initial;
    }

    // ask for confirmation if there is an existing session
    // skip it if some initial data is provided (deeplink)
    if (!widget.hasInitialData && WallabagInstance.isReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final settings = ref.read(settingsProvider);
        final result = await showOkCancelAlertDialog(
          context: context,
          title: context.L.login_existingSessionDialogTitle,
          message: context.L.login_existingSessionDialogMessage,
          okLabel: context.L.login_existingSessionDialogConfirm,
          isDestructiveAction: true,
        );
        if (result == OkCancelResult.ok) {
          await WallabagInstance.get().resetTokenData();
          settings.remove(Sk.lastRefresh);
          await DB.clear();
        } else {
          if (context.mounted) {
            context.go('/');
          }
        }
      });
    }

    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.warning),
                SizedBox(width: 8),
                Text('Behold!'),
              ],
            ),
            content: const Text(
              """
This build is giga experimental. A lot of things don't work, including data 
persistence and it will impose an additional load on your server.""",
            ),
            actions: [
              TextButton(
                child: const Text('I know, just let met go.'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hasInitialData &&
        !_hasBeenReset &&
        _currentData != widget.initial) {
      // when a deeplink is opened and the login page is already shown
      logger.info('override initial data');
      _currentData = widget.initial;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(serverLoginFlowProvider.notifier).reset();
      });
    }

    final serverCheck =
        ref.watch(serverLoginFlowProvider.select((value) => value.$2));

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: mediumBreakpoint),
          child: serverCheck == null || !serverCheck.isValid
              ? LoginFlowServer(initial: _currentData?['server'])
              : LoginFlowWallabag(
                  serverCheck: serverCheck,
                  initial: _currentData ?? {},
                  onReset: () => setState(() {
                    _currentData = null;
                    _hasBeenReset = true;
                  }),
                ),
        ),
      ),
    );
  }
}
