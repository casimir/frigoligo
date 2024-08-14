import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/cadanse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../buildcontext_extension.dart';
import '../../providers/server_login_flow.dart';
import '../../server/check.dart';
import '../../server/providers/client.dart';
import '../../server/session.dart';
import '../../services/wallabag_storage.dart';
import '../../wallabag/client.dart';
import '../../widget_keys.dart';
import 'login_freon.dart';
import 'login_wallabag.dart';
import 'utils.dart';

final _log = Logger('login');

class LoginFlowCredentials extends ConsumerStatefulWidget {
  LoginFlowCredentials({
    super.key,
    required this.serverCheck,
    this.initial = const {},
    this.onReset,
  }) {
    final rawServerType = serverCheck.info!.appname;
    final serverType = ServerType.values.byName(rawServerType);

    switch (serverType) {
      case ServerType.freon:
        loginController = FreonLoginFlowController();
      case ServerType.wallabag:
        loginController = WallabagLoginFlowController();
      case ServerType.unknown:
        throw UnknownServerTypeError(rawServerType);
    }
  }

  final ServerCheck serverCheck;
  late final LoginFlowController loginController;
  final Map<String, String> initial;
  final void Function()? onReset;

  @override
  ConsumerState<LoginFlowCredentials> createState() =>
      _LoginFlowCredentialsState();
}

class _LoginFlowCredentialsState extends ConsumerState<LoginFlowCredentials> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _gotAnError = false;

  @override
  void initState() {
    super.initState();

    if (widget.loginController.dataIsExhaustive(widget.initial)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        attemptLogin();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginFields = widget.loginController
        .getFields(context)
        .map(
          (e) => FormBuilderTextField(
            key: e.key,
            name: e.name,
            validator: (value) => notEmptyValidator(context, value, e.label),
            decoration: InputDecoration(
              icon: e.icon,
              labelText: e.label,
            ),
            obscureText: e.obscureText,
            autofocus: true,
            autocorrect: false,
          ) as Widget,
        )
        .toList();

    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Hero(
            tag: 'loginFlowServer',
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                widget.serverCheck.uri!.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  '${widget.serverCheck.info!.appname} ${widget.serverCheck.info!.version}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  ref.read(serverLoginFlowProvider.notifier).reset();
                  widget.onReset?.call();
                },
              ),
            ),
          ),
          C.spacers.verticalContent,
          Padding(
            padding: C.paddings.defaultPadding,
            child: FormBuilder(
              key: _formKey,
              initialValue: widget.initial,
              child: AutofillGroup(
                // It would be nice to provide a domain for autofill but it's dynamic.
                // https://developer.apple.com/documentation/xcode/supporting-associated-domains
                child: Column(
                  children: loginFields +
                      [
                        C.spacers.verticalContent,
                        ElevatedButton(
                          key: const Key(wkLoginFlowLogIn),
                          onPressed: () => attemptLogin(),
                          child: Text(context.L.login_actionLogin),
                        ),
                        C.spacers.verticalContent,
                        if (_gotAnError)
                          MaterialButton(
                            onPressed: () => context.push('/logs'),
                            child: Text(context.L.login_openLogConsole),
                          ),
                      ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> attemptLogin() async {
    if (_formKey.currentState!.saveAndValidate()) {
      try {
        final session = await widget.loginController
            .openSession(widget.serverCheck, _formKey.currentState!.value);
        await session.save();
        ref.invalidate(sessionProvider);
        ref.read(wStorageProvider.notifier).fullRefresh();
        if (mounted) {
          context.go('/');
        }
      } catch (e, st) {
        setState(() => _gotAnError = true);
        if (e is ServerError) {
          _log.warning('authentication failed', e.message);
          if (mounted) {
            showOkAlertDialog(context: context, message: e.message);
          }
        } else {
          _log.severe('unexpected error', e, st);
          if (mounted) {
            showOkAlertDialog(context: context, message: e.toString());
          }
        }
      }
    }
  }
}

abstract class LoginFlowController {
  bool dataIsExhaustive(Map<String, String> data);
  List<LoginField> getFields(BuildContext context);
  Future<ServerSession> openSession(
      ServerCheck check, Map<String, dynamic> values);
}

class LoginField {
  const LoginField({
    required this.name,
    required this.label,
    required this.icon,
    this.key,
    this.obscureText = false,
    this.autofocus = false,
    this.autofillHints,
  });

  final String name;
  final String label;
  final Icon icon;
  final Key? key;
  final bool obscureText;
  final bool autofocus;
  final List<String>? autofillHints;
}

class UnknownServerTypeError implements Exception {
  const UnknownServerTypeError(this.type);

  final String type;

  @override
  String toString() {
    return 'unknown server type: $type';
  }
}
