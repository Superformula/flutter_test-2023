import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/presentation/restaurant_detail/mixins/restaurant_detail_mixin.dart';
import 'package:restaurantour/presentation/widgets/widgets.dart';

class PriceCategoryBusinessHoursWidget extends StatelessWidget
    with RestaurantDetailMixin {
  final RestaurantEntity restaurantEntity;
  const PriceCategoryBusinessHoursWidget({
    super.key,
    required this.restaurantEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "${restaurantEntity.price} ${restaurantEntity.displayCategory}",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const Spacer(),
            showBusinessHoursStatus(
              restaurantEntity.isOpen,
            ),
            const SizedBox(
              width: 8,
            ),
            const BusinessHoursCircleStatusWidget(),
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
