import 'package:flutter/material.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/features/home_page/presenter/page/widgets/single_restaurant_card.dart';

class AllRestaurantsTab extends StatelessWidget {
  const AllRestaurantsTab({
    super.key,
    required this.restaurantList,
  });

  final List<Restaurant> restaurantList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0),
      itemCount: restaurantList.length,
      itemBuilder: (context, index) {
        final restaurant = restaurantList[index];
        return SingleRestaurantCard(
          restaurant: restaurant,
        );
      },
    );
  }
}
