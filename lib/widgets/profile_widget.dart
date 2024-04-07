import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/bloc/bloc.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  // const ProfileWidget({Key key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer.periodic(Duration(seconds: 10), (_) {
      // Call LoginByTokenEvent every 10 seconds
      context.read<AuthBloc>().add(LoginByTokenEvent());
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to prevent memory leaks
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
                Text('Name: ${state.response.firstName}'),
                Text('Last Name: ${state.response.lastName}'),
                Text('Email: ${state.response.email}'),
                Text('Gender: ${state.response.gender}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                    // StreamAuthScope.of(context).signOut();
                    // context.go('/');
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
