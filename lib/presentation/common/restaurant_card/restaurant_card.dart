import 'package:flutter/material.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/categories.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/image.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/price.dart';
import 'package:restaurantour/presentation/common/restaurant_rating/rating.dart';
import 'package:restaurantour/presentation/common/restaurant_status/restaurant_status.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/title.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const RestaurantCard(
    this.restaurant, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        borderOnForeground: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              RestaurantCardImage(
                restaurant.heroImage,
                heroId: restaurant.id ?? restaurant.name ?? "",
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: SizedBox(
                  height: 88.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RestaurantCardName(restaurant.name),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              RestaurantCardPrice(restaurant.price),
                              const SizedBox(width: 4.0),
                              RestaurantCardCategories(restaurant.categories),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RestaurantRating(restaurant.rating?.round()),
                              RestaurantStatus(restaurant.isOpen),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
