import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';

class BusinessHoursCircleStatusWidget extends StatelessWidget {
  const BusinessHoursCircleStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: AppColors.open,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
