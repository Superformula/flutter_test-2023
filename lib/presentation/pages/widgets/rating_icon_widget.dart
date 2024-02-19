import 'package:flutter/material.dart';

class RatingIcon extends StatelessWidget {
  final double rating;
  const RatingIcon({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int rate = rating.round();
    double dif = rating - rate;
    List<Widget> iconsList = [];
    for (var i = 0; i < rate; i++) {
      iconsList.add(
        const Icon(
          Icons.star,
          size: 15,
          color: Color.fromARGB(255, 238, 214, 2),
        ),
      );
    }
    if (dif > 0.0) {
      iconsList.add(
        const Icon(
          Icons.star_half,
          size: 15,
          color: Color.fromARGB(255, 238, 214, 2),
        ),
      );
    }
    return Row(children: iconsList);
  }
}
