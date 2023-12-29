import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../buildcontext_extension.dart';
import '../../wallabag/utils.dart';

import 'validators.dart';

class ServerForm extends StatefulWidget {
  const ServerForm(
      {super.key, required this.stateKey, this.onCheckChange, this.initial});

  final GlobalKey<FormBuilderState> stateKey;
  final void Function(WallabagServerCheck?)? onCheckChange;
  final String? initial;

  @override
  State<ServerForm> createState() => _ServerFormState();
}

class _ServerFormState extends State<ServerForm> {
  bool _checkPending = false;
  WallabagServerCheck? _serverCheck;

  bool get isValidAndChecked => _serverCheck?.isValid ?? false;

  @override
  Widget build(BuildContext context) {
    void startValidationAndCheck() {
      var state = widget.stateKey.currentState!;
      state.saveAndValidate();
      if (state.value['server'] != null) {
        _runServerCheck(state.value['server']);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionPanelList(
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return isValidAndChecked && !isExpanded
                  ? ListTile(
                      leading: const Icon(Icons.check),
                      title: Text(
                        context.L.g_server,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          '${_serverCheck!.uri} (${_serverCheck!.info!.version})'),
                    )
                  : ListTile(
                      leading: const Icon(Icons.home),
                      title: Text(context.L.g_server),
                    );
            },
            body: FormBuilder(
              key: widget.stateKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'server',
                      validator: (value) {
                        var emptyCheck = notEmptyValidator(
                            context, value, context.L.server_address);
                        if (emptyCheck != null) return emptyCheck;
                        if (_checkPending) return context.L.server_checkPending;
                        switch (_serverCheck?.errorKind) {
                          case WallabagCheckErrorKind.invalidUrl:
                            return context.L.server_invalidUrl;
                          case WallabagCheckErrorKind.unreachable:
                            return context.L.server_unreachable;
                          case WallabagCheckErrorKind.apiError:
                            return context.L.server_apiError;
                          case WallabagCheckErrorKind.unknown:
                            return '? ${_serverCheck!.error}';
                          case null:
                        }
                        return null;
                      },
                      readOnly: _checkPending,
                      decoration: InputDecoration(
                        labelText: context.L.server_address,
                        hintText: 'wallabag.domain.net',
                      ),
                      autocorrect: false,
                      onSubmitted: (_) => startValidationAndCheck(),
                      initialValue: widget.initial,
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: startValidationAndCheck,
                      child: Text(
                        _checkPending
                            ? context.L.g_checking
                            : context.L.g_check,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isExpanded: !isValidAndChecked,
          ),
        ],
        expansionCallback: (panelIndex, isExpanded) {
          if (panelIndex == 0 && !isExpanded && isValidAndChecked) {
            setState(() => _serverCheck = null);
            widget.onCheckChange?.call(_serverCheck);
          }
        },
      ),
    );
  }

  void _runServerCheck(String serverUrl) {
    if (_checkPending || isValidAndChecked) return;
    setState(() => _checkPending = true);
    checkWallabagServer(serverUrl).then((value) => setState(
          () {
            _checkPending = false;
            _serverCheck = value;
            widget.stateKey.currentState!.validate();
            widget.onCheckChange?.call(_serverCheck);
          },
        ));
  }
}
