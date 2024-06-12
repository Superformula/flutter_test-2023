import 'package:flutter/material.dart';
import 'package:restaurantour/core/design_system/restaurantour_sizes.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key? key, required this.rating}) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < (rating).round() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: RestaurantourSizes.size5,
        );
      }),
    );
  }
}
