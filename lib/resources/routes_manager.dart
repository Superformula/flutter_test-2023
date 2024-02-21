import 'package:restaurantour/screens/restaurant_detail.dart';
import 'package:restaurantour/screens/restaurants_screen.dart';

import '/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String homeRoute = "/";
  static const String restaurantDetailRoute = "/restaurantDetail";
}

class RouteGenerator {
  static PageRouteBuilder slideTransitionTo(
    Widget screen, {
    RouteSettings? routeSettings,
  }) {
    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder fadeTransitionTo(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return slideTransitionTo(const RestaurantsScreen());
      case Routes.restaurantDetailRoute:
        return slideTransitionTo(const RestaurantDetail(), routeSettings: routeSettings);

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
