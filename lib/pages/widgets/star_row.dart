import 'package:flutter/material.dart';

class StarRow extends StatelessWidget {
  final double rating;

  const StarRow({
    this.rating = 0.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          rating.floor(),
          (index) => const Icon(
            Icons.star,
            size: 12,
            color: Colors.amber,
          ),
        ),
        if (rating % 1 >= .5)
          const Icon(
            Icons.star_half,
            size: 12,
            color: Colors.amber,
          ),
      ],
    );
  }
}
