import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';

import '../../utils/typography/restaurantour_text_styles.dart';

class RestaurantPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name ?? '',
          style: RestaurantourTextStyles.h6,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: const Center(
        child: Text('Restaurants page'),
      ),
    );
  }
}
