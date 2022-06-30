import 'package:flutter/material.dart';
import 'package:restaurantour/ui/theme/app_color.dart';
import 'package:restaurantour/ui/values/padding_values.dart';

class OverallRating extends StatelessWidget {
  final double rating;

  const OverallRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          rating.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: PaddingValues.extraSmall,
            bottom: PaddingValues.s,
          ),
          child:
              Icon(Icons.star, color: AppColor.star, size: PaddingValues.big),
        ),
      ],
    );
  }
}
