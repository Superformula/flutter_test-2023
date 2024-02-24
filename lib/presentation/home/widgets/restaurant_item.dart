import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/app/widgets/widgets.dart';
import 'package:restaurantour/presentation/restaurant_details/restaurant_details.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({
    required this.restaurant,
    super.key,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;

    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 1),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
        color: Colors.white,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.pushNamed(
          RestaurantDetailsPage.routeName,
          extra: restaurant,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                restaurant.heroImage,
                fit: BoxFit.cover,
                height: 88,
                width: 88,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 88,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        restaurant.name ?? '',
                        style: typography.subtitle1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RestaurantInfo(
                              price: restaurant.price ?? '',
                              category: restaurant.displayCategory,
                            ),
                            const SizedBox(height: 4),
                            Stars(
                              rating: restaurant.rating ?? 0,
                            ),
                          ],
                        ),
                        RestaurantStatus(isOpenNow: restaurant.isOpen),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
