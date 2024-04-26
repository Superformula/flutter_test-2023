import 'package:flutter/material.dart';
import 'package:restaurantour/models/models.dart';

class RestaurantInfoText extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantInfoText({
    required this.restaurant,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final category = (restaurant.categories ?? [])
        .map((category) => category.title)
        .join(', ');

    return Text(
      '${restaurant.price ?? ""} $category',
      style: const TextStyle(
        fontSize: 12,
      ),
    );
  }
}
