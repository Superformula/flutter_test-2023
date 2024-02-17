import 'package:flutter/material.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/features/home_page/presenter/page/widgets/single_restaurant_card.dart';

class MyFavoritesTab extends StatelessWidget {
  const MyFavoritesTab({
    super.key,
    required this.favoriteList,
  });

  final List<Restaurant> favoriteList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0),
      itemCount: favoriteList.length,
      itemBuilder: (context, index) {
        final restaurant = favoriteList[index];
        return SingleRestaurantCard(
          restaurant: restaurant,
        );
      },
    );
  }
}
