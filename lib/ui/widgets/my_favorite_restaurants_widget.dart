import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/my_favorites/my_favorites_bloc.dart';
import '../../bloc/my_favorites/my_favorites_state.dart';
import '../../models/restaurant.dart';
import '../screens/restaurant_details_screen.dart';
import 'restaurant_list_tile.dart';

class MyFavoritesRestaurantsWidget extends StatelessWidget {
  const MyFavoritesRestaurantsWidget({Key? key}) : super(key: key);

  static const circularProcessIndicator = Center(
    child: CircularProgressIndicator(),
  );

  static const noRestaurantFound = Center(
    child: Text('No Favorites Restaurant Yet'),
  );

  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFavoritesBloc, MyFavoritesState>(
      builder: (context, state) {
        if (state is MyFavoritesLoading) {
          return circularProcessIndicator;
        }
        //
        else if (state is MyFavoritesLoaded) {
          var restaurants = state.restaurants;

          if (restaurants.isEmpty) {
            return noRestaurantFound;
          }

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return RestaurantListTile(
                restaurant: restaurants[index],
                onTap: () => pushRoute(context, restaurants, index),
              );
            },
          );
        }
        //
        return const Center(child: Text('Something went wrong!'));
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
