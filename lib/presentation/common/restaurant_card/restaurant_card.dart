import 'package:flutter/material.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/categories.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/image.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/price.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/rating.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/status.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/title.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard(this.restaurant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            RestaurantCardImage(restaurant.photos?[0]),
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
                            RestaurantCardCategories(restaurant.categories)
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RestaurantCardRating(restaurant.rating),
                            RestaurantCardStatus(restaurant.isOpen)
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
