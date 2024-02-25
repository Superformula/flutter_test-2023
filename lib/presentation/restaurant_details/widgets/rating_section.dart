import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/domain/restaurants/restaurants.dart';
import 'package:restaurantour/presentation/app/constants/constants.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/app/l10n/l10n.dart';
import 'package:restaurantour/presentation/app/widgets/widgets.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;
    final l10n = context.l10n;

    final restaurant = context.read<RestaurantDetailsCubit>().state.maybeWhen(
          loaded: (restaurant) => restaurant,
          orElse: () => const RestaurantEntity(),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.overallRating, style: typography.caption1),
        const SizedBox(height: Spacing.xlg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              restaurant.rating.toString(),
              style: typography.subtitle2?.copyWith(height: 0.36),
            ),
            const Stars(rating: 1, size: Spacing.lg),
          ],
        ),
      ],
    );
  }
}
