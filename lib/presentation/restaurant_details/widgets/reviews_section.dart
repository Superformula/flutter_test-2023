import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/app/l10n/l10n.dart';
import 'package:restaurantour/presentation/restaurant_details/restaurant_details.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;
    final l10n = context.l10n;

    final restaurant = context.read<RestaurantDetailsCubit>().state.restaurant;
    final reviewsList = restaurant?.reviews ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${reviewsList.length} ${l10n.reviews}',
          style: typography.caption1,
        ),
        const SizedBox(height: 16),
        if (restaurant != null)
          ...reviewsList
              .map(
                (review) => ReviewItem(review: review),
              )
              .toList(),
      ],
    );
  }
}
