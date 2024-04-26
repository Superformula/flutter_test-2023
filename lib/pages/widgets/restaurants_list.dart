import 'package:flutter/material.dart';
import 'package:restaurantour/models/models.dart';
import 'package:restaurantour/pages/widgets/restaurant_list_tile.dart';

class RestaurantsList extends StatelessWidget {
  final List<Restaurant> restaurants;

  const RestaurantsList({
    required this.restaurants,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            12,
            index == 0 ? 4.0 : 0,
            12,
            index == restaurants.length ? 4.0 : 0,
          ),
          child: RestaurantListTile(restaurant: restaurants[index]),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}
