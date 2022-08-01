import 'package:flutter/material.dart';
import 'package:restaurantour/ui/widgets/review_widget.dart';

import '../../models/restaurant.dart';

class RestaurantReviewsWidget extends StatelessWidget {
  const RestaurantReviewsWidget(
    this.restaurant, {
    this.isLast = true,
    this.padding = 25,
    Key? key,
  }) : super(key: key);

  final Restaurant restaurant;
  final bool isLast;
  final double padding;

  bool get hasReview => restaurant.reviews != null && restaurant.reviews!.isNotEmpty;

  String get reviewsTitle =>
      hasReview ? (restaurant.reviews!.length.toString() + ' ' + 'Reviews') : 'No Reviews';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(padding, padding, padding, 0),
      child: Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(reviewsTitle),
              ),
              if (hasReview)
                for (var i = 0; i < restaurant.reviews!.length; i++)
                  ReviewWidget(
                    restaurant.reviews![i],
                    padding: padding,
                    isLast: i == restaurant.reviews!.length - 1,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
