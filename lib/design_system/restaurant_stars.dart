import 'package:flutter/material.dart';

/// Represents the restaurant rating in only stars
class RestaurantStars extends StatelessWidget {
  const RestaurantStars({
    Key? key,
    required this.rating,
  }) : super(key: key);
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          if (index < rating.round()) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
