import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/favorites_restaurants/favorites_restaurants_bloc.dart';
import '../../business_logic/bloc/favorites_restaurants/favorites_restaurants_state.dart';
import 'restaurant_list_tile.dart';

class MyFavoritesRestaurantsWidget extends StatelessWidget {
  const MyFavoritesRestaurantsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesRestaurantsBloc, FavoritesRestaurantsState>(
      builder: (_, state) {
        if (state.restaurants.isNotEmpty) {
          return ListView.builder(
            itemCount: state.restaurants.length,
            itemBuilder: (_, index) => RestaurantListTile(
              restaurant: state.restaurants[index],
            ),
          );
        } else {
          return const Center(
            child: Text('No Favorites Restaurant Yet'),
          );
        }
      },
    );
  }
}
