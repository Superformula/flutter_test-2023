import 'package:flutter/material.dart';
import 'package:restaurantour_ui/restaurantour_ui.dart';

class Raiting extends StatelessWidget {
  const Raiting({Key? key, required this.rating}) : super(key: key);
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
