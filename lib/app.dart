import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_task/bloc/auth_bloc.dart';
import 'package:interview_task/products_screen.dart';
import 'package:interview_task/screens/home_screen.dart';
import 'package:interview_task/screens/login_screen.dart';

class App extends StatelessWidget {
  App({super.key});

  static const String title = 'GoRouter Example: Redirection';

  @override
  Widget build(BuildContext context) {
    GetIt.instance.registerLazySingleton<AuthBloc>(() => AuthBloc());

    return BlocProvider(
      create: (context) => GetIt.I<AuthBloc>(),
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
      final bool loggedIn = GetIt.instance<AuthBloc>().state is! UnauthenticatedState;
      final bool loggingIn = state.matchedLocation == '/login';

      if (!loggedIn) return '/login';
      if (loggingIn) return '/home';

      return null;
    },
    refreshListenable: GoRouterRefreshStream(GetIt.instance<AuthBloc>().stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
