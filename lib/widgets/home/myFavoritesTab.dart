import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/providers/restaurantProvider.dart';
import 'package:restaurantour/widgets/home/restaurantCard.dart';

class MyFavoritesTab extends StatelessWidget {
  const MyFavoritesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, child) {
        final favoriteRestaurants = restaurantProvider.getFavoriteRestaurants();

        if (favoriteRestaurants.isNotEmpty) {
          return ListView.builder(
            itemCount: favoriteRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = favoriteRestaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          );
        } else {
          return const Center(child: Text('No favorite restaurants yet.'));
        }
      },
    );
  }
}
