import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frigoligo/wallabag/wallabag.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: FormBuilder(
        key: _fbKey,
        child: Column(children: [
          FormBuilderTextField(
            name: 'server',
            validator: (value) => notEmptyValidator(value, 'server URL'),
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              labelText: 'Server URL',
            ),
          ),
          FormBuilderTextField(
            name: 'clientId',
            validator: (value) => notEmptyValidator(value, 'client ID'),
            decoration: const InputDecoration(
              icon: Icon(Icons.key),
              labelText: 'Client ID',
            ),
          ),
          FormBuilderTextField(
            name: 'clientSecret',
            validator: (value) => notEmptyValidator(value, 'client secret'),
            decoration: const InputDecoration(
              icon: Icon(Icons.key),
              labelText: 'Client Secret',
            ),
          ),
          FormBuilderTextField(
            name: 'username',
            validator: (value) =>
                value == null || value.isEmpty ? 'Enter your username' : null,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Username',
            ),
          ),
          FormBuilderTextField(
            name: 'password',
            validator: (value) =>
                value == null || value.isEmpty ? 'Enter your password' : null,
            obscureText: true, // TODO password visibility toggle
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              labelText: 'Password',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_fbKey.currentState!.saveAndValidate()) {
                var connData = WallabagConnectionData(
                  _fbKey.currentState!.value['server'],
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
        ]),
      ),
    );
  }
}

String? notEmptyValidator(String? value, String label) =>
    value == null || value.isEmpty ? 'Enter your $label' : null;
