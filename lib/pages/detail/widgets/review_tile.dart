import 'package:flutter/material.dart';
import 'package:restaurantour/models/models.dart';
import 'package:restaurantour/pages/widgets/star_row.dart';

class ReviewTile extends StatelessWidget {
  final Review review;
  const ReviewTile({required this.review, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StarRow(
          rating: (review.rating ?? 0).toDouble(),
        ),
        const SizedBox(height: 8),
        Text(
          review.text ?? 'N/A',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: review.user?.imageUrl != null
                  ? NetworkImage(review.user!.imageUrl!)
                  : null,
            ),
            const SizedBox(width: 8),
            Text(review.user != null ? review.user!.name! : 'Unknown user'),
          ],
        ),
      ],
    );
  }
}
