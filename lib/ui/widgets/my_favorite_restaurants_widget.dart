import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/my_favorites/favorites_restaurants_bloc.dart';
import '../../bloc/my_favorites/favorites_restaurants_state.dart';
import '../../models/restaurant.dart';
import '../screens/restaurant_details_screen.dart';
import 'restaurant_list_tile.dart';

class MyFavoritesRestaurantsWidget extends StatelessWidget {
  const MyFavoritesRestaurantsWidget({Key? key}) : super(key: key);

  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesRestaurantsBloc, FavoritesRestaurantsState>(
      builder: (context, state) {
        if (state.restaurants.isNotEmpty) {
          return ListView.builder(
            itemCount: state.restaurants.length,
            itemBuilder: (context, index) => RestaurantListTile(
              restaurant: state.restaurants[index],
              onTap: () => pushRoute(context, state.restaurants, index),
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

  void pushRoute(
    BuildContext context,
    List<Restaurant> restaurants,
    int index,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailsScreen(
          restaurant: restaurants[index],
        ),
      ),
    );
  }
}
