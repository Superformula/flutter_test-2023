import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';
import 'package:lost_app/lost_app.dart';
import 'package:restaurant_detail/restaurant_detail.dart';
import 'package:restaurant_list/restaurant_list.dart';
import 'package:yelp_repository/yelp_repository.dart';

class AppRouter {
  static Route<dynamic> generateRoute(
    RouteSettings settings, {
    required YelpRepository yelpRepository,
    required LocalStorage localStorage,
  }) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageName.restaurantList:
        return MaterialPageRoute(
          builder: (context) => RestaurantListView(
            yelpRepository: yelpRepository,
            localStorage: localStorage,
            onRestaurantTapped: (restaurant) => Navigator.of(context).pushNamed(
              PageName.restaurantDetail,
              arguments: restaurant,
            ),
          ),
        );

      case PageName.restaurantDetail:
        final restaurant = args as Restaurant;
        return MaterialPageRoute(
          builder: (context) => RestaurantDetailView(
            yelpRepository: yelpRepository,
            localStorage: localStorage,
            restaurant: restaurant,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const LostAppView(),
        );
    }
  }
}

class PageName {
  static const String restaurantList = 'restaurantList';
  static const String restaurantDetail = 'restaurantDetail';
}
