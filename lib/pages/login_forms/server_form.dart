import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frigoligo/wallabag/utils.dart';

import 'validators.dart';

class ServerForm extends StatefulWidget {
  const ServerForm({super.key, required this.stateKey, this.onCheckChange});

  final GlobalKey<FormBuilderState> stateKey;
  final void Function(WallabagServerCheck?)? onCheckChange;

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
                      title: const Text(
                        'Server',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          '${_serverCheck!.uri} (${_serverCheck!.info!.version})'),
                    )
                  : const ListTile(
                      leading: Icon(Icons.home), title: Text('Server'));
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
                        var emptyCheck =
                            notEmptyValidator(value, 'server address');
                        if (emptyCheck != null) return emptyCheck;
                        if (_checkPending) return 'Still checking...';
                        switch (_serverCheck?.errorKind) {
                          case WallabagCheckErrorKind.invalidUrl:
                            return 'Invalid address';
                          case WallabagCheckErrorKind.unreachable:
                            return 'Server unreachable';
                          case WallabagCheckErrorKind.apiError:
                            return 'Invalid server API';
                          case WallabagCheckErrorKind.unknown:
                            return '? ${_serverCheck!.error}';
                          case null:
                        }
                        return null;
                      },
                      readOnly: _checkPending,
                      decoration: const InputDecoration(
                        labelText: 'Server address',
                        hintText: 'wallabag.domain.net',
                      ),
                      autocorrect: false,
                      onSubmitted: (_) => startValidationAndCheck(),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: startValidationAndCheck,
                      child: Text(_checkPending ? 'Checking...' : 'Check'),
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
