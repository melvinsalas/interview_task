import 'package:flutter/material.dart';
import 'package:interview_task/app.dart';
import 'package:interview_task/stream_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StreamAuth info = StreamAuthScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(App.title),
        actions: <Widget>[
          IconButton(
            onPressed: () => info.signOut(),
            tooltip: 'Logout: ${info.currentUser}',
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
