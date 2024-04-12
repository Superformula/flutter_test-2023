import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restaurantour/contants/text_style_constants.dart';

class ReviewCardWidget extends StatelessWidget {
  const ReviewCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(8),
        Row(
          children: List.generate(
            5,
            (index) => const Icon(
              Icons.star,
              color: Colors.amber,
              size: 14,
            ),
          ),
        ),
        const Gap(12),
        Text(
          'Review text goes here. Review text goes here. Review text goes here. Review text goes here.',
          style: TextStylesClass.reviewRestaurantTextStyle,
        ),
        const Gap(12),
        Row(
          children: [
            CircleAvatar(
              child: Image.network(
                'https://gopostr.s3.amazonaws.com/favicon_url/CMXfauwVNmmVLyKpV0Qkg582dzzQWcp0Eje9gMiQ.png',
              ),
            ),
            const Gap(8),
            Text(
              'User Name',
              style: TextStylesClass.usernameTextStyle,
            ),
          ],
        ),
        const Gap(16),
      ],
    );
  }
}
