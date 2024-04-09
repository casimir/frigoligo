import 'package:cadanse/cadanse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../buildcontext_extension.dart';
import '../../providers/server_login_flow.dart';
import '../../wallabag/utils.dart';
import '../login_forms/validators.dart';

class LoginFlowServer extends ConsumerStatefulWidget {
  const LoginFlowServer({super.key, this.initial});

  final String? initial;

  @override
  ConsumerState<LoginFlowServer> createState() => _LoginFlowServerState();
}

class _LoginFlowServerState extends ConsumerState<LoginFlowServer> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final flowState =
        ref.watch(serverLoginFlowProvider.select((value) => value.$1));

    return Scaffold(
      body: Padding(
        padding: C.paddings.defaultPadding,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilderTextField(
                name: 'server',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _serverValidator,
                onChanged: (_) {
                  if (flowState == FlowState.checked) {
                    ref.read(serverLoginFlowProvider.notifier).reset();
                  }
                },
                enabled: flowState != FlowState.checking,
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
              C.spacers.verticalContent,
              ElevatedButton(
                onPressed: () {
                  if (flowState != FlowState.checking) {
                    _validateAndCheck();
                  }
                },
                child: Text(
                  flowState == FlowState.checking
                      ? context.L.g_checking
                      : context.L.g_check,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _serverValidator(String? value) {
    var emptyCheck =
        notEmptyValidator(context, value, context.L.server_address);
    if (emptyCheck != null) return emptyCheck;

    final (flowState, serverCheck) = ref.read(serverLoginFlowProvider);
    if (flowState == FlowState.checked) {
      switch (serverCheck!.errorKind) {
        case WallabagCheckErrorKind.invalidUrl:
          return context.L.server_invalidUrl;
        case WallabagCheckErrorKind.unreachable:
          return context.L.server_unreachable;
        case WallabagCheckErrorKind.apiError:
          return context.L.server_apiError;
        case WallabagCheckErrorKind.unknown:
          return '? ${serverCheck.error}';
        case null:
          return null;
      }
    }

    return null;
  }

  void _validateAndCheck() {
    if (_formKey.currentState!.saveAndValidate()) {
      final server = _formKey.currentState!.value['server'];
      ref.read(serverLoginFlowProvider.notifier).startCheckFor(server);
    }
  }
}
