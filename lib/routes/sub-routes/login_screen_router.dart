import 'package:go_router/go_router.dart';
import 'package:interview_task/routes/routes_base.dart';
import 'package:interview_task/screens/login_screen.dart';

abstract class LoginRoutes {
  static const login = '/login';
}

class LoginScreenRouter implements ScreenRouter {
  static final instance = LoginScreenRouter._internal();
  LoginScreenRouter._internal();

  factory LoginScreenRouter() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: LoginRoutes.login,
      builder: (context, state) => const LoginScreen(),
    );
  }
}
