import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/components/restaurants_list_view.dart';
import 'package:restaurantour/presentation/restaurants_cubit.dart';

class AllRestaurants extends StatelessWidget {
  const AllRestaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantsCubit, RestaurantsState>(
      builder: (context, state) {
        if (state is FailedToFetchRestaurants) return const SizedBox();
        if (state is NoRestaurantsFound) return const SizedBox();
        if (state is FetchingList) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }

        if (state is RestaurantsList) {
          return RestaurantsListView(restaurants: state.restaurants);
        }

        return const SizedBox();
      },
    );
  }
}
