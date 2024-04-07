import 'package:go_router/go_router.dart';
import 'package:interview_task/routes/routes_base.dart';
import 'package:interview_task/screens/screens.dart';

abstract class ProductsRoutes {
  static const products = '/products';
}

class ProductsScreenRouter implements ScreenRouter {
  static final instance = ProductsScreenRouter._internal();
  ProductsScreenRouter._internal();

  factory ProductsScreenRouter() {
    return instance;
  }

  @override
  RouteBase route() {
    return GoRoute(
      path: ProductsRoutes.products,
      builder: (context, state) => const ProductsScreen(),
    );
  }
}
