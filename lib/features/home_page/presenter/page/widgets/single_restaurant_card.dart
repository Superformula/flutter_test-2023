import 'package:flutter/material.dart';
import 'package:restaurantour/core/models/restaurant.dart';

class SingleRestaurantCard extends StatelessWidget {
  const SingleRestaurantCard({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(restaurant.name ?? 'No name provided'),
      ),
    );
  }
}
