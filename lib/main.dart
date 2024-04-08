import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_task/bloc/auth_bloc.dart';
import 'package:interview_task/bloc/products_bloc.dart';
import 'package:interview_task/screens/sale_screen.dart';
import 'package:interview_task/screens/home_screen.dart';
import 'package:interview_task/screens/login_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    GetIt.instance.registerLazySingleton<AuthBloc>(() => AuthBloc());
    GetIt.instance.registerLazySingleton<ProductsBloc>(() => ProductsBloc());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.instance<ProductsBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Interview Task',
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  /// The [GoRouter] configuration for the app.
  late final GoRouter _router = GoRouter(
    initialLocation: '/home',

    /// Define the routes for the app.
    routes: <GoRoute>[
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/sale', builder: (_, __) => const SaleScreen()),
    ],

    /// Redirect the user to the login screen if they are not logged in.
    redirect: (BuildContext context, GoRouterState state) async {
      final bool loggedIn = GetIt.instance<AuthBloc>().state is AuthenticatedState;
      final bool loggingIn = state.matchedLocation == '/login';

      if (!loggedIn) {
        GetIt.instance<ProductsBloc>().add(ResetProductsEvent());
        return '/login';
      }
      if (loggingIn) return '/home';

      return null;
    },

    /// Refresh the list of products when the user logs in or logs out.
    refreshListenable: GoRouterRefreshStream(GetIt.instance<AuthBloc>().stream),
  );
}

/// A [ChangeNotifier] that listens to a [Stream] and notifies its listeners
/// when the stream emits a new value.
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  /// Creates a [GoRouterRefreshStream] that listens to the given [stream].
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
