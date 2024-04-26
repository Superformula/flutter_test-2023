import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/logic/logic.dart';
import 'package:restaurantour/pages/widgets/restaurants_list.dart';

class AllRestaurantList extends StatelessWidget {
  const AllRestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        return state.maybeWhen(
          success: (restaurants) {
            return RestaurantsList(restaurants: restaurants);
          },
          error: (message) => Center(child: Text(message)),
          orElse: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
