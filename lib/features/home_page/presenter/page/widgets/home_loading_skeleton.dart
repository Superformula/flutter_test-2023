import 'package:flutter/material.dart';
import 'package:restaurantour/features/home_page/presenter/page/widgets/single_restaurant_card/single_restaurant_card_skeleton.dart';

class HomeLoadingSkeleton extends StatelessWidget {
  const HomeLoadingSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int itemCount = 6;

    return Expanded(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return const SingleRestaurantCardSkeleton();
        },
      ),
    );
  }
}
