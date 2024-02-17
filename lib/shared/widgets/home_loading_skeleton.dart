import 'package:flutter/material.dart';
import 'package:restaurantour/features/home_page/children/all_restaurant/presenter/page/widgets/single_restaurant_card/single_restaurant_card_skeleton.dart';

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
