import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_color.dart';

class Rating extends StatelessWidget {
  final double? rating;

  const Rating(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rating != null) {
      List<Widget> children = [];
      for (var i = 0; i < rating! ~/ 1; i++) {
        children.add(Icon(
          Icons.star,
          color: AppColors.star,
          size: 12.0,
        ));
      }
      return Row(
        children: children,
      );
    } else {
      return Container();
    }
  }
}
