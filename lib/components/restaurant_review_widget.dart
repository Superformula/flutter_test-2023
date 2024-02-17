import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurantour/core/rt_colors.dart';
import 'package:restaurantour/core/text_style.dart';

import 'package:restaurantour/models/restaurant.dart';

class RestaurantReviewWidget extends StatelessWidget {
  const RestaurantReviewWidget({super.key, required this.review, required this.isFirstItem});
  final bool isFirstItem;
  final Review review;
  final String reviewText = 'Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.';

  int get rating => review.rating ?? 0;
  List<Widget> get starRate => List.generate(rating > 5 ? 5 : rating.toInt(), (_) => SvgPicture.asset('assets/svg/star.svg'));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirstItem) const Divider(color: RTColors.dividerLine),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: starRate),
                const SizedBox(height: 8),
                Text(
                  reviewText,
                  style: RTTextStyle.body1(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: Image.network(
                          fit: BoxFit.cover,
                          review.user?.imageUrl ?? '',
                          errorBuilder: (_, __, ___) => Container(
                            color: RTColors.placeholder,
                            child: const Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      review.user?.name ?? '',
                      style: RTTextStyle.caption(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
