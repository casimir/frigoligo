import 'package:flutter/material.dart';
import 'package:frigoligo/server_presets.dart';
import 'package:frigoligo/wallabag/wallabag.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
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
    // TODO server preset dialog
    var data = WallabagConnectionData(
      serverPresets[0].server,
      serverPresets[0].clientId!,
      serverPresets[0].clientSecret!,
    );
    WallabagInstance.initWith(data);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Your username or email address',
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    return value!.isEmpty ? 'Enter your username' : null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Your super secret password',
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    return value!.isEmpty ? 'Enter your password' : null;
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                WallabagInstance.get()
                    .fetchToken(
                        _usernameController.text, _passwordController.text)
                    .then((_) => Navigator.pushNamedAndRemoveUntil(
                        context, '/', (r) => false));
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
