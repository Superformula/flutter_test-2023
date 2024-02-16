import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../common/restaurant_item.dart';

class RestaurantsListPage extends StatelessWidget with GetItMixin {
  RestaurantsListPage({
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
            onPressed: () async {},
          ),
          const RestaurantItem(),
        ],
      ),
    );
  }
}
