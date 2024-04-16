import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_outlined,
            color: Colors.red,
            size: 100,
          ),
          Text(
            AppWords.somethingWentWrong,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}
