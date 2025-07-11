import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../buildcontext_extension.dart';
import '../../providers/server_login_flow.dart';
import '../../server/check.dart';
import 'utils.dart';

final _log = Logger('login.check');

class LoginFlowServer extends ConsumerStatefulWidget {
  const LoginFlowServer({super.key, this.initial});

  final String? initial;

  @override
  ConsumerState<LoginFlowServer> createState() => _LoginFlowServerState();
}

class _LoginFlowServerState extends ConsumerState<LoginFlowServer> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late String? _currentValue;

  @override
  void initState() {
    super.initState();

    _currentValue = widget.initial;
    if (_currentValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _validateAndCheck();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentValue != widget.initial) {
      // when a deeplink is opened and the login page is already shown
      _log.info('override initial server URL');
      _currentValue = widget.initial;
      _formKey.currentState?.fields['server']?.didChange(_currentValue);
      if (_currentValue != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _validateAndCheck();
        });
      }
    }

    final flowState = ref.watch(serverLoginFlowProvider);

    return PaddedGroup(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'loginFlowServer',
              child: FormBuilderTextField(
                name: 'server',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _serverValidator,
                onChanged: (_) {
                  if (flowState is FSChecked) {
                    ref.read(serverLoginFlowProvider.notifier).reset();
                  }
                },
                enabled: flowState is! FSChecking,
                decoration: InputDecoration(
                  icon: const Icon(Icons.home),
                  labelText: context.L.server_address,
                  hintText: 'wallabag.domain.net',
                ),
                autofocus: true,
                autocorrect: false,
                onSubmitted: (_) => _validateAndCheck(),
                initialValue: widget.initial,
              ),
            ),
            FormBuilderCheckbox(
              name: 'selfSigned',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: kSpacingBetweenGroups,
              ),
              title: Text(context.L.login_acceptSelfSigned),
              onChanged: (_) {
                if (flowState is FSChecked) {
                  ref.read(serverLoginFlowProvider.notifier).reset();
                }
              },
              enabled: flowState is! FSChecking,
              initialValue: false,
            ),
            C.spacers.verticalContent,
            ElevatedButton(
              onPressed: () {
                if (flowState is! FSChecking) {
                  _validateAndCheck();
                }
              },
              child: Text(
                flowState is FSChecking
                    ? context.L.g_checking
                    : context.L.g_check,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _serverValidator(String? value) {
    var emptyCheck = notEmptyValidator(
      context,
      value,
      context.L.server_address,
    );
    if (emptyCheck != null) return emptyCheck;

    final flowState = ref.read(serverLoginFlowProvider);
    if (flowState is FSChecked) {
      final check = flowState.check;
      return switch (check.errorKind) {
        ServerCheckErrorKind.invalidUrl => context.L.server_invalidUrl,
        ServerCheckErrorKind.unknownServerType =>
          context.L.server_unknownServerType,
        ServerCheckErrorKind.unreachable => context.L.server_unreachable,
        ServerCheckErrorKind.versionNotSupported =>
          context.L.server_versionNotSupported,
        ServerCheckErrorKind.unknown => '? ${check.error}',
        null => null,
      };
    }
    return null;
  }

  void _validateAndCheck() {
    if (_formKey.currentState!.saveAndValidate()) {
      final server = _formKey.currentState!.value['server'];
      final selfSigned = _formKey.currentState!.value['selfSigned'] ?? false;
      ref.read(serverLoginFlowProvider.notifier).checkFor(server, selfSigned);
    }
  }
}
