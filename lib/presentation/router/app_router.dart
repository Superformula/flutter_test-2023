import 'package:flutter/material.dart';

import '../screens/restarautour_home_screen.dart';
import '../screens/restaurant_details_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RestauranTourHomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RestauranTourHomeScreen(),
        );
      case RestaurantDetailsScreen.routeName:
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
