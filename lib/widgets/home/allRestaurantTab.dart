import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/providers/restaurantProvider.dart';
import 'package:restaurantour/widgets/home/restaurantCard.dart';

class AllRestaurantsTab extends StatelessWidget {
  const AllRestaurantsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, child) {
        final restaurants = restaurantProvider.restaurants;

        if (restaurants != null) {
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
