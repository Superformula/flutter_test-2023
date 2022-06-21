import 'package:flutter/material.dart';
import 'package:restaurantour/features/restauran_tour/screens/restauran_tour.dart';
import 'package:restaurantour/features/restauran_tour/screens/restaurant_detail_screen.dart';

class AppRoutes {
  static String initialRoute = '/';
  static String restaurantDetailRoute = "/restaurant_detail_screen";

  static setUpRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      initialRoute: (BuildContext context) => const RestauranTour(),
      restaurantDetailRoute: (BuildContext context) =>
          const ResturantDetailScreen(),
    };
  }
}
