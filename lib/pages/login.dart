import 'package:flutter/material.dart';
import 'package:frigoligo/wallabag/wallabag.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  final WallabagClient wallabag = WallabagInstance.get();

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
                widget.wallabag
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
