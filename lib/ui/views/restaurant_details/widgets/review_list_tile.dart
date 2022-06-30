import 'package:flutter/material.dart';
import 'package:restaurantour/data/models/models.dart';
import 'package:restaurantour/ui/values/values.dart';
import 'package:restaurantour/ui/views/restaurant_details/widgets/divider_line.dart';
import 'package:restaurantour/ui/widgets/rating.dart';

class ReviewListTile extends StatelessWidget {
  final Review review;

  static const defaultImage = 'https://picsum.photos/200';

  const ReviewListTile({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...[
          if (review.rating != null)
            Padding(
              padding: const EdgeInsets.only(bottom: PaddingValues.medium),
              child: Rating(rating: review.rating!),
            ),
          if (review.text != null)
            Padding(
              padding: const EdgeInsets.only(bottom: PaddingValues.medium),
              child: Text(
                review.text!,
                style: textTheme.bodyText1,
              ),
            ),
          if (review.user != null)
            Row(
              children: [
                CircleAvatar(
                  radius: PaddingValues.xl,
                  backgroundImage:
                      NetworkImage(review.user!.imageUrl ?? defaultImage),
                ),
                const SizedBox(width: PaddingValues.medium),
                Expanded(
                  child: Text(
                    review.user!.name ?? '',
                    style: textTheme.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
        ],
        const DividerLine(
          padding: EdgeInsets.symmetric(vertical: PaddingValues.l),
        ),
      ],
    );
  }
}
