import 'package:flutter/material.dart';

class RestaurantCardRating extends StatelessWidget {
  final double? rating;
  const RestaurantCardRating(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arr =
        List<int>.generate(rating != null ? rating!.round() : 0, (i) => i + 1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...arr
            .map((_) => Icon(
                  Icons.star,
                  color: Colors.amber[800],
                  size: 14.0,
                  semanticLabel: 'Rating',
                ))
            .toList()
      ],
    );
  }
}
