import 'package:flutter/material.dart';
import 'package:restaurantour/features/restaurant_tour/models/restaurant.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/detail_restaurant/detail_restaurant.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/home_restaurant/home_restaurant.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomeResturant());
      case '/detail-restaurant':
        return _materialRoute(
          DetailRestaurant(
            restaurant: settings.arguments as Restaurant,
          ),
        );
      default:
        return _materialRoute(const HomeResturant());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
