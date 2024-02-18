import 'package:flutter/material.dart';
import 'package:restaurantour/shared/widgets/single_restaurant_card/single_restaurant_card_export.dart';

class CardsLoadingSkeleton extends StatelessWidget {
  const CardsLoadingSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int itemCount = 6;

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return const SingleRestaurantCardSkeleton();
      },
    );
  }
}
