import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restaurantour/contants/text_style_constants.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/utils/rating_calculator.dart';

class RestaurantCardWidget extends StatelessWidget {
  const RestaurantCardWidget({Key? key, required this.restaurantData})
      : super(key: key);
  final Restaurant restaurantData;

  @override
  Widget build(BuildContext context) {
    //Get overall rating
    final int overallRating = restaurantData.reviews?.isNotEmpty ?? false
        ? RatingCalculator.calculateAverageRating(restaurantData.reviews!)
            .round()
        : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          height: 104,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: restaurantData.heroImage.isNotEmpty
                        ? NetworkImage(restaurantData.heroImage)
                        : const AssetImage('assets/img/no_image_available.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantData.name ?? 'No restaurant name found',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStylesClass.restaurantCardTitleTextStyle,
                    ),
                    const Gap(8),
                    Text(
                      '${restaurantData.price ?? 'N/A'} ${restaurantData.categories?.isNotEmpty == true ? restaurantData.categories!.first.title : "N/A"}',
                      style: TextStylesClass.priceCategoryTextStyle,
                    ),
                    const Gap(6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(
                            overallRating,
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              restaurantData.isOpen == true
                                  ? 'Open Now'
                                  : 'Closed',
                              style:
                                  TextStylesClass.openCloseRestaurantTextStyle,
                            ),
                            const Gap(6),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: restaurantData.isOpen
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
