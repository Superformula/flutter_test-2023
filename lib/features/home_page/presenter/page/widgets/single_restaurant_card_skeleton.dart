import 'package:flutter/material.dart';
import 'package:restaurantour/shared/tr_skeleton.dart';

class SingleRestaurantCardSkeleton extends StatelessWidget {
  const SingleRestaurantCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: TrSkeleton(
          height: 120,
          width: MediaQuery.sizeOf(context).width * 0.95,
        ),
      ),
    );
  }
}
