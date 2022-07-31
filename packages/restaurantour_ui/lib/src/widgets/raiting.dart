import 'package:flutter/material.dart';
import 'package:restaurantour_ui/restaurantour_ui.dart';

class Rating extends StatelessWidget {
  const Rating({Key? key, required this.rating}) : super(key: key);
  final int rating;
  @override
  Widget build(BuildContext context) {
    const double starSize = 12.0;
    return Row(
      children: List.generate(
        rating,
        (_) => const Padding(
          padding:
              EdgeInsets.only(right: RestaurantourPaddingValues.extraSmall),
          child: Icon(
            Icons.star,
            color: RestaurantourColors.star,
            size: starSize,
          ),
        ),
      ),
    );
  }
}
