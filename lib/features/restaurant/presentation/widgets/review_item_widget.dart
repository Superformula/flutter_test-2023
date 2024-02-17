import 'package:flutter/material.dart';
import 'package:restaurantour/features/restaurant/domain/entities/review_entity.dart';
import 'package:restaurantour/features/restaurant/presentation/widgets/star_rating_widget.dart';

class ReviewItemWidget extends StatelessWidget {
  const ReviewItemWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  final ReviewEntity? review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StarRatingWidget(rating: review?.rating?.toDouble()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              review?.text ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Row(
            children: [
              if (review?.user?.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      review!.user!.imageUrl!,
                    ),
                  ),
                ),
              Text(
                review?.user?.name ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
