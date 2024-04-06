import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_task/bloc/bloc.dart';
import 'package:interview_task/screens/screens.dart';
import 'package:logger/web.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/${HomeScreen.path}',
      builder: (_, __) => const HomeScreen(),
      routes: <RouteBase>[
        GoRoute(path: LoginScreen.path, builder: (_, __) => const LoginScreen()),
        GoRoute(path: ProductsScreen.path, builder: (_, __) => const ProductsScreen()),
      ],
      redirect: (context, state) async {
        final status = context.read<AuthBloc>().state;
        if (status is UnauthenticatedState) {
          Logger().i('Redirecting to /login');
          return '/${LoginScreen.path}';
        }
        Logger().i('Redirecting to ${HomeScreen.path}');
        return null;
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ProductsBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
