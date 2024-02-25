import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/domain/restaurants/restaurants.dart';
import 'package:restaurantour/injection_container/config_dependencies.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';
import 'package:restaurantour/presentation/restaurant_details/view/view.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({
    required this.restaurant,
    Key? key,
  }) : super(key: key);

  final RestaurantEntity restaurant;

  static const routeName = 'restaurant-details-page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RestaurantDetailsCubit>()
        ..initialize(
          restaurant: restaurant,
        ),
      child: const RestaurantDetailsView(),
    );
  }
}
