import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/bloc/auth_bloc.dart';
import 'package:interview_task/utils/text_field_custom.dart';

class LoginFormWidget extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginFormWidget({super.key});

  void _onLogin(BuildContext context) {
    context
        .read<AuthBloc>()
        .add(LoginEvent(username: _usernameController.text, password: _passwordController.text));
  }

  void _fillForm() {
    _usernameController.text = 'kminchelle';
    _passwordController.text = '0lelplR';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFieldCustom(
              hintText: 'Username',
              controller: _usernameController,
              prefixIcon: const Icon(Icons.person),
            ),
            const SizedBox(height: 16),
            TextFieldCustom(
              obscureText: true,
              controller: _passwordController,
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fillForm,
              style: ElevatedButton.styleFrom(elevation: 0),
              child: const Text('Need help? Autofill the form'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _onLogin(context),
              style: ElevatedButton.styleFrom(
                elevation: 1,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Login', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
