import 'package:flutter/material.dart';
import 'package:restaurantour/features/home_page/presenter/page/widgets/single_restaurant_card_skeleton.dart';
class HomeLoadingSkeleton extends StatelessWidget {
  const HomeLoadingSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SingleRestaurantCardSkeleton(),
        SingleRestaurantCardSkeleton(),
        SingleRestaurantCardSkeleton(),
        SingleRestaurantCardSkeleton(),
        SingleRestaurantCardSkeleton(),
        SingleRestaurantCardSkeleton(),
      ],
    );
  }
}