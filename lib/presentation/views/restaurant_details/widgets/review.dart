import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/common/restaurant_rating/rating.dart';

class RestaurantReview extends StatelessWidget {
  final Review review;
  const RestaurantReview(this.review, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RestaurantRating(
          review.rating,
          size: 12.0,
        ),
        const SizedBox(height: 12.0),
        Text(
          review.text ?? "--------",
          softWrap: true,
          style: GoogleFonts.openSans(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(review.user!.imageUrl ?? ""),
            ),
            const SizedBox(width: 4.0),
            Text(
              review.user?.name ?? "",
              style: GoogleFonts.openSans(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
