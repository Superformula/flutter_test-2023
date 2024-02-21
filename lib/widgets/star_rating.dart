import 'package:flutter/material.dart';
import 'package:restaurantour/resources/color_manager.dart';
import 'package:restaurantour/utils/helper_utils.dart';

class StarRating extends StatelessWidget {
  final double? rating;
  final double? size;
  const StarRating({
    Key? key,
    this.rating,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final starCount = Utils.roundDoubleToInt(rating);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        starCount,
        (index) => Icon(
          Icons.star,
          color: ColorManager.yellow,
          size: size,
        ),
      ),
    );
  }
}
