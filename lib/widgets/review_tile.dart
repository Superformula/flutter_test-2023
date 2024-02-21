import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/resources/resources_exports.dart';
import 'package:restaurantour/utils/mock_data.dart';
import 'package:restaurantour/widgets/star_rating.dart';

class ReviewTile extends StatelessWidget {
  final Review review;

  const ReviewTile({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StarRating(rating: review.rating?.toDouble(), size: AppSize.size16),
        SizedBox(height: AppPadding.padding4.h),
        Text(MockData.loremReview),
        SizedBox(height: AppPadding.padding8.h),
        Row(
          children: [
            if (review.user?.imageUrl != null)
              CircleAvatar(
                backgroundImage: NetworkImage(review.user?.imageUrl ?? ''),
              )
            else
              CircleAvatar(
                backgroundColor: ColorManager.blue,
                child: Text(
                  review.user?.name?.substring(0, 1) ?? '',
                  style: TextStyle(fontSize: FontSize.s24.sp, color: ColorManager.white),
                ),
              ),
            SizedBox(width: AppPadding.padding8.h),
            Text(review.user?.name ?? AppStrings.noData),
          ],
        ),
      ],
    );
  }
}
