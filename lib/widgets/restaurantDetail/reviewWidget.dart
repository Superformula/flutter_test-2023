import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/widgets/restaurantDetail/ratingStars.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;

  const ReviewWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [RatingStars(rating: review.rating!)],
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Feel free to share your thoughts and experiences about this restaurant. Your feedback is valuable to us and helps other diners make informed choices. Unfortunately, the current repository doesnt include specific comments.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              review.user?.imageUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(review.user!.imageUrl!),
                    )
                  : const Icon(
                      Icons.person,
                      size: 40.0, // Ajusta el tamaño según sea necesario
                    ),
              const SizedBox(width: 8.0),
              Text(
                review.user?.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
