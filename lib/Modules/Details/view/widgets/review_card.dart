import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/rating_stars_icon.dart';
import 'package:restaurantour/models/restaurant.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingStarsIcon(
          amount: review.rating!.toDouble(),
        ),
        const SizedBox(height: 10),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ornare sit amet nisl vitae pellentesque. Suspendisse libero est, pulvinar ut molestie dignissim, aliquet vel neque.',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const CircleAvatar(
              radius: 24, // Image radius
            ),
            const SizedBox(width: 8),
            Text(
              review.user!.name!,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
