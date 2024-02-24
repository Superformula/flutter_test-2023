import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/presentation/home/home.dart';
import 'package:restaurantour/presentation/restaurant_details/restaurant_details.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter({
    String? initialLocation = '/',
  }) {
    _goRouter = _routes(initialLocation);
  }

  late final GoRouter _goRouter;

  GoRouter get routes => _goRouter;

  GoRouter _routes(String? initialLocation) {
    return GoRouter(
      initialLocation: initialLocation,
      debugLogDiagnostics: kDebugMode,
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: RestaurantDetailsPage.routeName,
          path: '/${RestaurantDetailsPage.routeName}',
          builder: (context, state) {
            final restaurant = state.extra as Restaurant;
            return RestaurantDetailsPage(restaurant: restaurant);
          },
        ),
      ],
    );
  }
}
