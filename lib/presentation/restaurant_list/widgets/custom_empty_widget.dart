import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurantour/core/utils/utils.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            child: SvgPicture.asset(
              ImagePath.emptyState,
            ),
          ),
          Text(
            AppWords.noFavoritesYet,
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
