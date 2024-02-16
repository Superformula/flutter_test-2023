import 'package:flutter/material.dart';
import 'package:restaurantour/features/home_page/presenter/page/widgets/single_restaurant_card_skeleton.dart';

class AllRestaurantsTab extends StatelessWidget {
  const AllRestaurantsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleRestaurantCardSkeleton(),
            SingleRestaurantCardSkeleton(),
            SingleRestaurantCardSkeleton(),
            SingleRestaurantCardSkeleton(),
            Text('All Restaurants'),
          ],
        ),
      ),
    );
  }
}
