import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/views/restaurant/widgets/review.dart';
import 'package:restaurantour/presentation/views/restaurant/widgets/spaced_divider.dart';

class ReviewList extends StatelessWidget {
  final List<Review> reviewList;
  final int reviewCount;
  const ReviewList(this.reviewList, this.reviewCount, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${reviewCount.toString()} Review${reviewCount > 1 ? 's' : ''}",
            style: GoogleFonts.openSans(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16.0),
          ...reviewList
              .map(
                (review) => [
                  RestaurantReview(
                    review,
                  ),
                  const SpacedDivider(padding: 12.0),
                ],
              )
              .expand((i) => i)
              .toList(),
        ],
      ),
    );
  }
}
