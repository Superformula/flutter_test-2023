import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../common/review_item.dart';
import '../models/restaurant.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import '../utils/text_styles.dart';
import '../common/details_appbar.dart';
import '../common/padded_divider.dart';

@RoutePage()
class DetailsPage extends StatelessWidget with GetItMixin {
  DetailsPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Restaurant item;

  @override
  Widget build(BuildContext context) {
    final cleanIsOpen = item.isOpen ? AppStrings.openNow : AppStrings.closed;
    final circleColor = item.isOpen ? AppColors.green : AppColors.red;

    return Scaffold(
      appBar: DetailsAppBar(item: item),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              item.heroImage,
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
                        item.displayCategory,
                        style: AppTextStyles.openSans12,
                      ),
                      const Spacer(),
                      Text(
                        cleanIsOpen,
                        style: AppTextStyles.openSans12.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.circle_rounded,
                        color: circleColor,
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
                    item.location!.formattedAddress!,
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
                        item.rating!.toString(),
                        style: AppTextStyles.lora28,
                      ),
                      const Icon(
                        Icons.star,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                  const PaddedDivider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.reviews?.length} ${AppStrings.reviews}'),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: item.reviews?.length ?? 0,
                        itemBuilder: (context, index) {
                          final rObjectIndex = item.reviews?[index];
                          final isFirst = index == 0 ? true : false;

                          return ReviewItem(
                            item: rObjectIndex!,
                            isFirst: isFirst,
                          );
                        },
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
