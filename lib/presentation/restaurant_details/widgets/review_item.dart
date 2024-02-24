import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/app/widgets/widgets.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    required this.review,
    super.key,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stars(rating: review.rating?.toDouble() ?? 0),
        const SizedBox(height: 8),
        Text(review.text ?? '', style: typography.body1),
        const SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                review.user?.imageUrl ??
                    /// TODO: Remove this link and add the image in the assets
                    'http://chasesolar.org.uk/files/2022/02/blank-avatar.jpg',
              ),
            ),
            const SizedBox(width: 8),
            Text(
              review.user?.name ?? '',
              style: typography.caption1,
            ),
          ],
        ),
        const Divider(height: 32),
      ],
    );
  }
}
