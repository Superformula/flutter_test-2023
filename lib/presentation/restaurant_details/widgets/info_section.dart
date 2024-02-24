import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/app/widgets/widgets.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = context.read<RestaurantDetailsCubit>().state.maybeWhen(
          loaded: (restaurant) => restaurant,
          orElse: () => const Restaurant(),
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RestaurantInfo(
          price: restaurant.price ?? '',
          category: restaurant.displayCategory,
        ),
        RestaurantStatus(isOpenNow: restaurant.isOpen),
      ],
    );
  }
}
