import 'package:cached_network_image/cached_network_image.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final Review review;
  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:
              List.generate(review.rating ?? 0, (index) => const RatingStar())
                  .toList(),
        ),
        const SizedBox(height: 8.0),
        Text(
          review.text ?? '',
          maxLines: 3,
        ),
        Row(
          children: [
            SizedBox.square(
              dimension: 40.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: CachedNetworkImage(
                  imageUrl: review.user?.imageUrl ?? '',
                  errorWidget: (_, __, ___) => const Icon(Icons.person),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(review.user?.name ?? ''),
          ],
        ),
      ],
    );
  }
}
