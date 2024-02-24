import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurantour/presentation/app/constants/constants.dart';

class Stars extends StatelessWidget {
  const Stars({
    required this.rating,
    this.size = Spacing.md,
    super.key,
  });

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating.round().toDouble(),
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: rating.round(),
      itemSize: size,
      direction: Axis.horizontal,
    );
  }
}
