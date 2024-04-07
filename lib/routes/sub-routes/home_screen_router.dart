import 'package:go_router/go_router.dart';
import 'package:interview_task/routes/routes_base.dart';
import 'package:interview_task/screens/screens.dart';

abstract class HomeRoutes {
  static const home = '/home';
}

class HomeScreenRouter implements ScreenRouter {
  static final instance = HomeScreenRouter._internal();
  HomeScreenRouter._internal();

  factory HomeScreenRouter() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: HomeRoutes.home,
      builder: (context, state) => const HomeScreen(),
    );
  }
}
