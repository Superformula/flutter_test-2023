import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../models/restaurant.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import 'padded_divider.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.item,
    required this.isFirst,
  });

  final Review item;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFirst) const PaddedDivider(vertical: 16),
        RatingStars(
          starCount: 5,
          starColor: AppColors.yellow,
          valueLabelVisibility: false,
          value: item.rating!.roundToDouble(),
          starSize: 12,
          starSpacing: 0,
        ),
        const SizedBox(height: 8),
        Text(
          item.id!,
          softWrap: true,
          style: AppTextStyles.openSans16,
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: item.user!.imageUrl == null
                    ? const ColoredBox(
                        color: AppColors.green,
                      )
                    : Image.network(
                        item.user!.imageUrl!,
                      ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              item.user!.name!,
              style: AppTextStyles.openSans14,
            ),
          ],
        ),
      ],
    );
  }
}
