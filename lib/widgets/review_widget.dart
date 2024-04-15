import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;
  const ReviewWidget({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                review.rating ?? 0,
                (index) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 20,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(review.text ?? ""),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(review.user!.imageUrl ?? ""),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(review.user!.name ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
