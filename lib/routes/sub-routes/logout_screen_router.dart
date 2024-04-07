import 'package:go_router/go_router.dart';
import 'package:interview_task/routes/routes_base.dart';
import 'package:interview_task/screens/lougout_screen.dart';

abstract class LogoutRoutes {
  static const logout = '/logout';
}

class LogoutScreenRouter implements ScreenRouter {
  static final instance = LogoutScreenRouter._internal();
  LogoutScreenRouter._internal();

  factory LogoutScreenRouter() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: LogoutRoutes.logout,
      builder: (context, state) => const LogoutScreen(),
    );
  }
}
