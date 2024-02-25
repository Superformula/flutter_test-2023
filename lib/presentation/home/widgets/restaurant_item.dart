import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/domain/restaurants/restaurants.dart';
import 'package:restaurantour/presentation/app/constants/constants.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/app/widgets/widgets.dart';
import 'package:restaurantour/presentation/restaurant_details/restaurant_details.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({
    required this.restaurant,
    super.key,
  });

  final RestaurantEntity restaurant;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;
    final colors = appTheme.colors;

    return Container(
      margin: const EdgeInsets.only(
        left: Spacing.md,
        right: Spacing.md,
        top: Spacing.md,
      ),
      padding: const EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: (colors.black ?? Colors.black).withOpacity(0.12),
            offset: const Offset(0, 1),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
        color: colors.white,
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
              borderRadius: BorderRadius.circular(Spacing.sm),
              child: Container(
                color: Colors.transparent,
                child: Image.network(
                  restaurant.heroImage,
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress?.cumulativeBytesLoaded ==
                            loadingProgress?.expectedTotalBytes
                        ? child
                        : const LoadingShimmer();
                  },
                  fit: BoxFit.cover,
                  height: Spacing.xxxlg * Spacing.xxs,
                  width: Spacing.xxxlg * Spacing.xxs,
                ),
              ),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: SizedBox(
                height: Spacing.xxxlg * Spacing.xxs,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: Spacing.xxs),
                      child: Text(restaurant.name, style: typography.subtitle1),
                    ),
                    const SizedBox(height: Spacing.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RestaurantInfo(
                              price: restaurant.price,
                              category: restaurant.displayCategory,
                            ),
                            const SizedBox(height: Spacing.xs),
                            Stars(rating: restaurant.rating),
                          ],
                        ),
                        RestaurantStatus(isOpenNow: restaurant.isOpen),
                      ],
                    ),
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
