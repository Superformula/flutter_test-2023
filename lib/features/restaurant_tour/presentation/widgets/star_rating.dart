import 'package:flutter/material.dart';
import 'package:restaurantour/theme/style.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;

  const StarRating({Key? key, required this.rating, this.starSize = 30.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfStars = rating.round();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(numberOfStars, (index) {
        return Icon(
          Icons.star,
          color: starColor,
          size: starSize,
        );
      }),
    );
  }
}
