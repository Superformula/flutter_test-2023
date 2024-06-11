import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/components/restaurants_list_view.dart';
import 'package:restaurantour/presentation/list/favorite_restaurants_cubit.dart';

class FavoriteRestaurants extends StatelessWidget {
  const FavoriteRestaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteRestaurantsCubit, List<Restaurant>>(
      builder: (context, favoriteRestaurants) {
        if (favoriteRestaurants.isEmpty) {
          return const Center(
            child: Text('No favorites'),
          );
        }
        return RestaurantsListView(restaurants: favoriteRestaurants);
      },
    );
  }
}
