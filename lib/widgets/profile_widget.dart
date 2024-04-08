import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/bloc/auth_bloc.dart';
import 'package:interview_task/utils/elevated_button_custom.dart';
import 'package:interview_task/utils/text_field_custom.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      context.read<AuthBloc>().add(LoginByTokenEvent());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(image: NetworkImage(state.response.image)),
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: '${state.response.firstName} ${state.response.lastName}',
                  enabled: false,
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: state.response.email,
                  enabled: false,
                  prefixIcon: const Icon(Icons.alternate_email),
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: state.response.gender,
                  enabled: false,
                  prefixIcon: const Icon(Icons.wc),
                ),
                const SizedBox(height: 8),
                ElevatedButtonCustom(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                  text: 'Logout',
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
