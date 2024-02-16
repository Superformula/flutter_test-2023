import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rate;
  final double starSize;
  final Color color;

  const RatingStars({
    Key? key,
    required this.rate,
    this.starSize = 20.0,
    this.color = Colors.amber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    int wholeStars = rate.floor();
    bool isHalfStar = rate - wholeStars >= 0.5;

    for (int i = 0; i < wholeStars; i++) {
      stars.add(Icon(Icons.star, size: starSize, color: color));
    }

    if (isHalfStar) {
      stars.add(Icon(Icons.star_half, size: starSize, color: color));
    }

    return Row(children: stars);
  }
}
