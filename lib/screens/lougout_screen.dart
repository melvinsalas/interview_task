import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_task/bloc/bloc.dart';
import 'package:interview_task/routes/sub-routes/login_screen_router.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(LogoutEvent());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          GoRouter.of(context).go(LoginRoutes.login);
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text('Logout...'),
        ),
      ),
    );
  }
}
