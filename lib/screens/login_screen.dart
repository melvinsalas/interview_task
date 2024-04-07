import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_task/bloc/auth_bloc.dart';
import 'package:interview_task/screens/screens.dart';
import 'package:interview_task/stream_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String path = 'login';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          context.go('/home');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Login'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginEvent('kminchelle', '0lelplR'));
                      // StreamAuthScope.of(context).signIn('test-user');
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
