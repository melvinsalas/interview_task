import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_task/bloc/bloc.dart';
import 'package:interview_task/routes/sub-routes/home_screen_router.dart';
import 'package:interview_task/routes/sub-routes/login_screen_router.dart';
import 'package:interview_task/routes/sub-routes/logout_screen_router.dart';
import 'package:interview_task/routes/sub-routes/products_screen_router.dart';
import 'package:logger/logger.dart';

abstract class AppRouter {
  static final GoRouter dashboardRouter = GoRouter(
    initialLocation: HomeRoutes.home,
    routes: [
      LoginScreenRouter.instance.route(),
      HomeScreenRouter.instance.route(),
      ProductsScreenRouter.instance.route(),
      LogoutScreenRouter.instance.route(),
    ],
    redirect: (context, state) async {
      final status = context.read<AuthBloc>().state;
      if (status is UnauthenticatedState) {
        if (state.path != LoginRoutes.login) {
          Logger().i('Redirecting to login');
          return LoginRoutes.login;
        }
      }
      return null;
    },
  );
}
