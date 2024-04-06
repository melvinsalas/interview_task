import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_task/screens/screens.dart';
import 'package:interview_task/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String path = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          children: [
            const ProfileWidget(),
            ElevatedButton(
              onPressed: () {
                context.go('/${ProductsScreen.path}');
              },
              child: const Text('Products'),
            ),
          ],
        ),
      ),
    );
  }
}
