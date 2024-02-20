import 'package:go_router/go_router.dart';
import 'package:restaurantour/features/details/details_screen.dart';
import 'package:restaurantour/features/restaurants/restaurants_screen.dart';

class RTRoute {
  final String name;
  final String path;
  final List<String> params;

  RTRoute({required this.name, required this.path, this.params = const <String>[]});
}

class GoRouterConfig {
  static RTRoute home = RTRoute(name: 'home', path: '/');
  static RTRoute details = RTRoute(name: 'details', path: '/details/:restaurant_id', params: ['restaurant_id']);

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: GoRouterConfig.home.name,
        path: GoRouterConfig.home.path,
        builder: (context, state) => RestaurantsScreen.create(),
      ),
      GoRoute(
        name: GoRouterConfig.details.name,
        path: GoRouterConfig.details.path,
        builder: (context, state) {
          final restaurantId = state.pathParameters[details.params[0]];
          return DetailsScreen.create(restaurantId: restaurantId);
        },
      ),
    ],
  );
}
