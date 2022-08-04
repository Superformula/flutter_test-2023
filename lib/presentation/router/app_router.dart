import 'package:flutter/material.dart';

import '../screens/restarautour_home_screen.dart';
import '../screens/restaurant_details_screen.dart';

class AppRouter {
  AppRouter._();

  static const restauranTourHomeScreenRouteName = '/';
  static const restaurantDetailsScreenRouteName = '/restaurantDetails';

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case restauranTourHomeScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const RestauranTourHomeScreen(),
        );
      case restaurantDetailsScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const RestaurantDetailsScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Center(child: Text('No route defined')),
        );
    }
  }
}
