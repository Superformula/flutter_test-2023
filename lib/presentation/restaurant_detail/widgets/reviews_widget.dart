import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/presentation/restaurant_detail/mixins/restaurant_mixin.dart';
import 'package:restaurantour/presentation/widgets/widgets.dart';

class ReviewsWidget extends StatelessWidget with RestaurantMixin {
  const ReviewsWidget({super.key, required this.restaurantEntity});

  final RestaurantEntity restaurantEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${restaurantEntity.reviews?.length} ${AppWords.reviews}",
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.black,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const SizedBox(
          height: 8,
        ),
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            ...List.generate(
              restaurantEntity.reviews?.length ?? 0,
              (index) {
                final isLastItem =
                    index == (restaurantEntity.reviews?.length ?? 0) - 1;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRatingBarWidget(
                      rating: displayReviewRating(
                        restaurantEntity.reviews![index],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppWords.fakeReview,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                    child: CircleAvatar(
                                      radius: 24,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              displayUserImage(
                                                restaurantEntity.reviews ?? [],
                                              ),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    displayUserName(
                                      restaurantEntity.reviews![index],
                                    ),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              if (!isLastItem)
                                const Divider(
                                  color: AppColors.lightGray,
                                ),
                              const SizedBox(height: 14),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
