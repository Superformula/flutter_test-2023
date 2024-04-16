import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/presentation/restaurant_detail/mixins/restaurant_mixin.dart';

class AddressOverallRatingWidget extends StatelessWidget with RestaurantMixin {
  const AddressOverallRatingWidget({super.key, required this.restaurantEntity});

  final RestaurantEntity restaurantEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppWords.address,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          displayAddress(
            restaurantEntity.location as LocationEntity,
          ),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const Divider(
          color: AppColors.lightGray,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          AppWords.overallRating,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "${restaurantEntity.rating}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 2,
                top: 5,
              ),
              child: Icon(
                Icons.star,
                size: 20,
                color: AppColors.star,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        const Divider(
          color: AppColors.lightGray,
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
