import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/cadanse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../buildcontext_extension.dart';
import '../../providers/server_login_flow.dart';
import '../../services/remote_sync.dart';
import '../../wallabag/credentials.dart';
import '../../wallabag/utils.dart';
import '../../wallabag/wallabag.dart';
import '../../widget_keys.dart';
import 'utils.dart';

class LoginFlowWallabag extends ConsumerStatefulWidget {
  const LoginFlowWallabag({
    super.key,
    required this.serverCheck,
    this.initial = const {},
    this.onReset,
  });

  final WallabagServerCheck serverCheck;
  final Map<String, String> initial;
  final void Function()? onReset;

  @override
  ConsumerState<LoginFlowWallabag> createState() => _LoginFlowWallabagState();
}

class _LoginFlowWallabagState extends ConsumerState<LoginFlowWallabag> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _gotAnError = false;

  @override
  void initState() {
    super.initState();

    final initialIsExhaustive = widget.initial.isNotEmpty &&
        widget.initial.containsKey('clientId') &&
        widget.initial.containsKey('clientSecret') &&
        widget.initial.containsKey('username') &&
        widget.initial.containsKey('password');
    if (initialIsExhaustive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        attemptLogin(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    FormBuilderTextField(
                      key: const Key(wkLoginFlowClientId),
                      name: 'clientId',
                      validator: (value) => notEmptyValidator(
                          context, value, context.L.login_fieldClientId),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.key),
                        labelText: context.L.login_fieldClientId,
                      ),
                      autofocus: true,
                      autocorrect: false,
                    ),
                    FormBuilderTextField(
                      name: 'clientSecret',
                      validator: (value) => notEmptyValidator(
                          context, value, context.L.login_fieldClientSecret),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        labelText: context.L.login_fieldClientSecret,
                      ),
                      autocorrect: false,
                    ),
                    FormBuilderTextField(
                      name: 'username',
                      validator: (value) => notEmptyValidator(
                          context, value, context.L.login_fieldUsername),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        labelText: context.L.login_fieldUsername,
                      ),
                      autocorrect: false,
                      autofillHints: const [AutofillHints.username],
                    ),
                    FormBuilderTextField(
                      name: 'password',
                      validator: (value) => notEmptyValidator(
                          context, value, context.L.login_fieldPassword),
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password),
                        labelText: context.L.login_fieldPassword,
                      ),
                      autocorrect: false,
                      autofillHints: const [AutofillHints.password],
                    ),
                    C.spacers.verticalContent,
                    ElevatedButton(
                      key: const Key(wkLoginFlowLogIn),
                      onPressed: () => attemptLogin(context),
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

  Future<void> attemptLogin(BuildContext context) async {
    if (_formKey.currentState!.saveAndValidate()) {
      final credentials = Credentials(
        widget.serverCheck.uri!,
        _formKey.currentState!.value['clientId'],
        _formKey.currentState!.value['clientSecret'],
      );
      try {
        final wallabag = await WallabagInstance.init(credentials: credentials);
        await wallabag.fetchToken(_formKey.currentState!.value['username'],
            _formKey.currentState!.value['password']);
        ref.read(remoteSyncerProvider.notifier).invalidateWallabagInstance();
        if (context.mounted) {
          context.go('/');
        }
      } catch (e) {
        setState(() => _gotAnError = true);
        if (e is WallabagError) {
          logger.warning('authentication failed', e.message);
          if (context.mounted) {
            showOkAlertDialog(context: context, message: e.message);
          }
        } else {
          logger.severe('unexpected error', e);
          if (context.mounted) {
            showOkAlertDialog(context: context, message: e.toString());
          }
        }
      }
    }
  }
}
