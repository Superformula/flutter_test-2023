import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';

class CustomRatingBarWidget extends StatelessWidget {
  final int rating;

  const CustomRatingBarWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : null,
          color: AppColors.star,
          size: 14,
        );
      }),
    );
  }
}
