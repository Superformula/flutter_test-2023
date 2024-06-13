import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color color;

  const StarRating({
    Key? key,
    this.starCount = 5,
    this.rating = .0,
    required this.color,
  }) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index < rating.floor()) {
      icon = Icon(
        Icons.star,
        size: 12,
        color: color,
      );
    } else if (index == rating.floor() && rating - rating.floor() < 0.5) {
      icon = Icon(
        Icons.star_border,
        size: 12,
        color: color,
      );
    } else if (index == rating.floor() && rating - rating.floor() >= 0.5) {
      icon = Icon(
        Icons.star,
        size: 12,
        color: color,
      );
    } else {
      icon = Icon(
        Icons.star_border,
        size: 12,
        color: color,
      );
    }
    return InkResponse(
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
