import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/cadanse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../buildcontext_extension.dart';
import '../../providers/server_login_flow.dart';
import '../../server/check.dart';
import '../../server/freon.dart';
import '../../services/remote_sync.dart';
import '../../wallabag/client.dart';
import '../../widget_keys.dart';
import 'login_credentials.dart';
import 'utils.dart';

class LoginFlowFreon extends ConsumerStatefulWidget
    implements LoginFlowCredentials {
  const LoginFlowFreon({
    super.key,
    required this.serverCheck,
    this.initial = const {},
    this.onReset,
  });

  final ServerCheck serverCheck;
  final Map<String, String> initial;
  final void Function()? onReset;

  @override
  ConsumerState<LoginFlowFreon> createState() => _LoginFlowFreonState();
}

class _LoginFlowFreonState extends ConsumerState<LoginFlowFreon> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _gotAnError = false;

  @override
  void initState() {
    super.initState();

    final initialIsExhaustive =
        widget.initial.isNotEmpty && widget.initial.containsKey('apiToken');
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
                      name: 'apiToken',
                      validator: (value) => notEmptyValidator(
                          context, value, context.L.session_fieldApiToken),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.token),
                        labelText: context.L.session_fieldApiToken,
                      ),
                      autofocus: true,
                      autocorrect: false,
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
      final credentials = FreonCredentials(
        widget.serverCheck.uri!,
        _formKey.currentState!.value['apiToken'],
      );
      try {
        final freon = FreonClient(credentials);
        await freon.wallabag.getInfo();
        FreonCredentialsManager(await SharedPreferences.getInstance())
            .credentials = credentials;
        ref.read(remoteSyncerProvider.notifier).invalidateWallabagInstance();
        if (context.mounted) {
          context.go('/');
        }
      } catch (e) {
        setState(() => _gotAnError = true);
        if (e is ServerError) {
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
