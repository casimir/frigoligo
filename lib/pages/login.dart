import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frigoligo/wallabag/wallabag.dart';

import 'login_forms/server_form.dart';
import 'login_forms/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _serverFbKey = GlobalKey<FormBuilderState>();
  bool _serverConfigured = false;
  final _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        children: [
          ServerForm(
            stateKey: _serverFbKey,
            onCheckChange: (check) => setState(() {
              _serverConfigured = check?.isValid ?? false;
            }),
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
                    ),
                    FormBuilderTextField(
                      name: 'clientSecret',
                      validator: (value) =>
                          notEmptyValidator(value, 'client secret'),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.key),
                        labelText: 'Client Secret',
                      ),
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
                    ),
                    const SizedBox(height: 8.0),
                  ]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              if (_serverConfigured && _fbKey.currentState!.saveAndValidate()) {
                var connData = WallabagConnectionData(
                  _serverFbKey.currentState!.value['server'],
                  _fbKey.currentState!.value['clientId'],
                  _fbKey.currentState!.value['clientSecret'],
                );
                WallabagInstance.initWith(connData).then((wallabag) {
                  wallabag!
                      .fetchToken(_fbKey.currentState!.value['username'],
                          _fbKey.currentState!.value['password'])
                      .then((_) => Navigator.pushNamedAndRemoveUntil(
                          context, '/', (r) => false));
                });
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
