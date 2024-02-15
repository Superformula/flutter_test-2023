import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../repositories/yelp_repository.dart';
import '../widgets/restaurant_item.dart';

class RestaurantsListPage extends StatelessWidget {
  const RestaurantsListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Restaurantour'),
          ElevatedButton(
            child: const Text('Fetch Restaurants'),
            onPressed: () async {
              _fetchRestaurantData();
            },
          ),
          const RestaurantItem(),
        ],
      ),
    );
  }
}

Future<RestaurantQueryResult?> _fetchRestaurantData() async {
  final yelpRepo = YelpRepository();

  try {
    final result = await yelpRepo.getRestaurants();
    if (result != null) {
      print(
        'Fetched ${result.restaurants!.length} restaurants',
      );

      return result;
    } else {
      print('No restaurants fetched');

      return null;
    }
  } catch (e) {
    print('Failed to fetch restaurants: $e');

    return null;
  }
}
