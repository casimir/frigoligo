import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frigoligo/wallabag/wallabag.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../models/db.dart';
import '../providers/settings.dart';
import '../wallabag/credentials.dart';
import 'login_forms/server_form.dart';
import 'login_forms/validators.dart';

final _log = Logger('login');

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.initial});

  final Map<String, String>? initial;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Map<String, String>? _initialData;
  final _serverFbKey = GlobalKey<FormBuilderState>();
  bool _serverConfigured = false;
  final _fbKey = GlobalKey<FormBuilderState>();
  bool _gotAnError = false;

  @override
  void initState() {
    super.initState();
    _initialData = widget.initial;
    if (WallabagInstance.isReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final settings = context.read<SettingsProvider>();
        final result = await showOkCancelAlertDialog(
          context: context,
          title: 'A session is already open',
          message:
              'Do you want to log out of the current session and open a new one?',
          okLabel: 'Log out',
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
  }

  @override
  Widget build(BuildContext context) {
    if (_initialData != widget.initial) {
      // when a deeplink is opened and the login page is already shown
      _initialData = widget.initial;
      if (_initialData?['server'] != null) {
        _serverFbKey.currentState?.fields['server']!
            .didChange(_initialData!['server']);
      }
      for (final key in ['clientId', 'clientSecret', 'username', 'password']) {
        if (_initialData?[key] != null) {
          _fbKey.currentState?.fields[key]!.didChange(_initialData![key]);
        }
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Log in')),
      body: ListView(
        children: [
          ServerForm(
            stateKey: _serverFbKey,
            onCheckChange: (check) => setState(() {
              _serverConfigured = check?.isValid ?? false;
            }),
            initial: widget.initial?['server'],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              surfaceTintColor: Colors.transparent,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
                  key: _fbKey,
                  enabled: _serverConfigured,
                  child: Column(children: [
                    FormBuilderTextField(
                      name: 'clientId',
                      validator: (value) =>
                          notEmptyValidator(value, 'client ID'),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.key),
                        labelText: 'Client ID',
                      ),
                      initialValue: widget.initial?['clientId'],
                    ),
                    FormBuilderTextField(
                      name: 'clientSecret',
                      validator: (value) =>
                          notEmptyValidator(value, 'client secret'),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.key),
                        labelText: 'Client Secret',
                      ),
                      initialValue: widget.initial?['clientSecret'],
                    ),
                    FormBuilderTextField(
                      name: 'username',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your username'
                          : null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Username',
                      ),
                      initialValue: widget.initial?['username'],
                    ),
                    FormBuilderTextField(
                      name: 'password',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your password'
                          : null,
                      obscureText: true, // TODO password visibility toggle
                      decoration: const InputDecoration(
                        icon: Icon(Icons.password),
                        labelText: 'Password',
                      ),
                      initialValue: widget.initial?['password'],
                    ),
                    const SizedBox(height: 8.0),
                  ]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () async {
              if (_serverConfigured && _fbKey.currentState!.saveAndValidate()) {
                final credentials = Credentials(
                  _serverFbKey.currentState!.value['server'],
                  _fbKey.currentState!.value['clientId'],
                  _fbKey.currentState!.value['clientSecret'],
                );
                try {
                  final wallabag =
                      await WallabagInstance.init(credentials: credentials);
                  await wallabag.fetchToken(
                      _fbKey.currentState!.value['username'],
                      _fbKey.currentState!.value['password']);
                  if (context.mounted) {
                    context.go('/');
                  }
                } catch (e) {
                  setState(() => _gotAnError = true);
                  if (e is WallabagError) {
                    _log.warning('authentication failed', e.message);
                    if (context.mounted) {
                      showOkAlertDialog(context: context, message: e.message);
                    }
                  } else {
                    _log.severe('unexpected error', e);
                    if (context.mounted) {
                      showOkAlertDialog(
                          context: context, message: e.toString());
                    }
                  }
                }
              }
            },
            child: const Text('Log in'),
          ),
          const SizedBox(height: 8.0),
          if (_gotAnError)
            MaterialButton(
              onPressed: () => context.push('/logs'),
              child: const Text('Open the Log Console'),
            ),
        ],
      ),
    );
  }
}
