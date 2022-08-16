import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/screens/restaurant_detail_screen.dart';

import '../models/restaurant.dart';
import 'restaurant_tile.dart';

class AllRestaurantsList extends StatelessWidget {
  const AllRestaurantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      padding: EdgeInsets.all(12),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantDetailScreen(restaurant: Restaurant()),
            ),
          ),
          child: RestaurantTile(),
        );
      },
    );
  }
}
