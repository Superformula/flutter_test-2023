import 'dart:math';

import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({Key? key, required this.rating}) : super(key: key);

  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < min(rating?.round() ?? 0, 5); i++)
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 16,
          ),
      ],
    );
  }
}
