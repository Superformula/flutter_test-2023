import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restaurantour/contants/text_style_constants.dart';

class ReviewCardWidget extends StatelessWidget {
  const ReviewCardWidget({
    Key? key,
    this.rating = 0,
    this.username = "User name",
    this.userImgUrl,
  }) : super(key: key);
  final int? rating;
  final String? username;
  final String? userImgUrl;

  @override
  Widget build(BuildContext context) {
    int roundedRating = rating!.round();
    return Column(
      children: [
        const Gap(8),
        Row(
          children: List.generate(
            roundedRating,
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
              backgroundImage: NetworkImage(
                userImgUrl ??
                    'https://gopostr.s3.amazonaws.com/favicon_url/CMXfauwVNmmVLyKpV0Qkg582dzzQWcp0Eje9gMiQ.png',
              ),
            ),
            const Gap(8),
            Text(
              username!,
              style: TextStylesClass.captionTextStyle,
            ),
          ],
        ),
        const Gap(16),
      ],
    );
  }
}
