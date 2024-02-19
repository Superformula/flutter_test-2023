import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/utils/colors.dart';
import 'package:restaurantour/utils/strings.dart';

import 'package:restaurantour/utils/text_styles.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Restaurant item;

  @override
  Widget build(BuildContext context) {
    final cleanIsOpen = item.isOpen ? AppStrings.openNow : AppStrings.closed;
    final circleColor = item.isOpen ? AppColors.green : AppColors.red;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              child: Image.network(
                item.heroImage,
                height: 88,
                width: 88,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name!,
                    style: AppTextStyles.lora16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      item.displayCategory,
                      style: AppTextStyles.openSans12,
                    ),
                  ),
                  Row(
                    children: [
                      RatingStars(
                        starCount: 5,
                        starColor: AppColors.yellow,
                        valueLabelVisibility: false,
                        value: item.rating!.roundToDouble(),
                        starSize: 12,
                        starSpacing: 0,
                      ),
                      const Spacer(),
                      Text(
                        cleanIsOpen,
                        style: AppTextStyles.openSans12.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.circle_rounded,
                        color: circleColor,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
