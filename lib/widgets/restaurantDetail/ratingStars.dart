import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;

  const RatingStars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        rating,
        (index) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ),
    );
  }
}
