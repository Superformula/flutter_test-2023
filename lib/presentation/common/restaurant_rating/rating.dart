import 'package:flutter/material.dart';

class RestaurantRating extends StatelessWidget {
  final int? rating;
  final double size;
  const RestaurantRating(this.rating, {Key? key, this.size = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arr = List<int>.generate(rating != null ? rating! : 0, (i) => i + 1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...arr
            .map(
              (_) => Icon(
                Icons.star,
                color: Colors.amber[800],
                size: size,
                semanticLabel: 'Rating',
              ),
            )
            .toList(),
      ],
    );
  }
}
