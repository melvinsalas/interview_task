import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_task/bloc/auth_bloc.dart';
import 'package:interview_task/home_screen.dart';
import 'package:interview_task/login_screen.dart';
import 'package:interview_task/products_screen.dart';
import 'package:interview_task/stream_auth.dart';

class App extends StatelessWidget {
  App({super.key});

  static const String title = 'GoRouter Example: Redirection';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp.router(
        routerConfig: _router,
        title: title,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  late final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: <GoRoute>[
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/products', builder: (_, __) => const ProductsScreen()),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      final bool loggedIn = await StreamAuthScope.of(context).isSignedIn();
      final bool loggingIn = state.matchedLocation == '/login';

      if (!loggedIn) return '/login';
      if (loggingIn) return '/home';

      return null;
    },
  );
}
