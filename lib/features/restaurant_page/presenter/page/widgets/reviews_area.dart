import 'package:flutter/material.dart';
import 'package:restaurantour/core/models/restaurant.dart';

class ReviewsArea extends StatelessWidget {
  const ReviewsArea({
    super.key,
    required this.reviews,
  });

  final List<Review>? reviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reviews ${reviews?.length}'),
              Text('${reviews?.first.rating}'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'restaurant.location?.formattedAddress ?? '','
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
