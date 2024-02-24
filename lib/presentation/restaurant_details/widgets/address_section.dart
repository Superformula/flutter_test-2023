import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/app/l10n/l10n.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;
    final l10n = context.l10n;

    final restaurant = context.read<RestaurantDetailsCubit>().state.maybeWhen(
          loaded: (restaurant) => restaurant,
          orElse: () => const Restaurant(),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.address, style: typography.caption1),
        const SizedBox(height: 24),
        Text(
          restaurant.location?.formattedAddress ?? '',
          style: typography.caption2,
        ),
      ],
    );
  }
}
