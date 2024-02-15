import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:restaurantour/utils/colors.dart';

import '../utils/strings.dart';
import '../utils/text_styles.dart';
import '../widgets/details_appbar.dart';
import '../widgets/padded_divider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailsAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://picsum.photos/id/10/300',
              fit: BoxFit.cover,
              height: 361,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '\$\$\$\$ Italian',
                        style: AppTextStyles.openSans12,
                      ),
                      const Spacer(),
                      Text(
                        AppStrings.openNow,
                        style: AppTextStyles.openSans12.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.circle_rounded,
                        color: AppColors.green,
                        size: 12,
                      ),
                    ],
                  ),
                  const PaddedDivider(),
                  Text(
                    AppStrings.address,
                    style: AppTextStyles.openSans12,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '102 Lakeside Ave',
                    style: AppTextStyles.openSans14,
                  ),
                  Text(
                    'Seattle, WA 98122',
                    style: AppTextStyles.openSans14,
                  ),
                  const PaddedDivider(),
                  Text(
                    AppStrings.overallRating,
                    style: AppTextStyles.openSans12,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '4.6',
                        style: AppTextStyles.lora28,
                      ),
                      const Icon(
                        Icons.star,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                  const PaddedDivider(),
                  const Text('42 ${AppStrings.reviews}'),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RatingStars(
                        starCount: 5,
                        starColor: AppColors.yellow,
                        valueLabelVisibility: false,
                        value: 5,
                        starSize: 12,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.',
                        softWrap: true,
                        style: AppTextStyles.openSans16,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.network(
                                'https://picsum.photos/id/11/100',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'User Name',
                            style: AppTextStyles.openSans14,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
