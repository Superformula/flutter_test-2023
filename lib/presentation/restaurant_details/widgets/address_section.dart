import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;

    final restaurant = context.read<RestaurantDetailsCubit>().state.restaurant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Address', style: typography.caption1),
        const SizedBox(height: 24),
        Text(
          restaurant?.location?.formattedAddress ?? '',
          style: typography.caption2,
        ),
      ],
    );
  }
}
