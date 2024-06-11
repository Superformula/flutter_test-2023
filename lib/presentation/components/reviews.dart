import 'package:flutter/material.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/components/rating_stars.dart';

class Reviews extends StatelessWidget {
  const Reviews({Key? key, required this.reviews}) : super(key: key);

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${reviews.length} Reviews',
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
        for (var i = 0; i < reviews.length; i++)
          ReviewItem(
            review: reviews[i],
            showDivider: i < reviews.length - 1,
          ),
      ],
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    Key? key,
    required this.review,
    required this.showDivider,
  }) : super(key: key);
  final Review review;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        RatingStars(rating: review.rating?.toDouble()),
        if (review.text != null) const SizedBox(height: 5),
        if (review.text != null) Text(review.text ?? ''),
        const SizedBox(height: 5),
        Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  review.user?.imageUrl ?? '',
                  errorBuilder: (_, __, ___) {
                    return const SizedBox.square(
                      dimension: 32,
                      child: Icon(Icons.person),
                    );
                  },
                  fit: BoxFit.cover,
                  height: 32,
                  width: 32,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              review.user?.name ?? '',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        if (showDivider) const Divider(),
      ],
    );
  }
}
