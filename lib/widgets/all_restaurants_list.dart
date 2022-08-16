import 'package:flutter/material.dart';

import 'restaurant_tile.dart';

class AllRestaurantsList extends StatelessWidget {
  const AllRestaurantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      padding: EdgeInsets.all(12),
      itemBuilder: (context, index) => RestaurantTile(),
    );
  }
}
