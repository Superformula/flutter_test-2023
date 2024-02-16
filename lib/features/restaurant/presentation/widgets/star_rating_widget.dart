import 'package:flutter/material.dart';
import 'package:restaurantour/common/ui/app_colors.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double? rating;

  @override
  Widget build(BuildContext context) {
    return rating != null
        ? Row(
            children: List.generate(
              rating!.round(),
              (_) => const Icon(
                Icons.star,
                size: 12,
                color: AppColors.kDandyDaffodilYellow,
              ),
            ),
          )
        : Container();
  }
}
