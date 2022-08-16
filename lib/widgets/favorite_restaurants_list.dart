import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superformula_flutter_test/widgets/no_data_found_widget.dart';

import '../blocs/restaurant_list/restaurant_list_bloc.dart';
import '../models/restaurant.dart';
import 'restaurant_tile.dart';

class FavoriteRestaurantsList extends StatefulWidget {
  const FavoriteRestaurantsList({Key? key}) : super(key: key);
  @override
  State<FavoriteRestaurantsList> createState() => _FavoriteRestaurantsListState();
}

class _FavoriteRestaurantsListState extends State<FavoriteRestaurantsList> {
  @override
  Widget build(BuildContext context) {
    final RestaurantListBloc restaurantListBloc = BlocProvider.of<RestaurantListBloc>(context);
    final List<Restaurant> favoriteRestaurants = restaurantListBloc.favoriteRestaurants;
    return BlocBuilder<RestaurantListBloc, RestaurantListState>(
      builder: (context, state) {
        if (favoriteRestaurants.isNotEmpty) {
          return ListView.builder(
            itemCount: favoriteRestaurants.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) => RestaurantTile(restaurant: favoriteRestaurants[index]),
          );
        }
        return NoDataFoundWidget();
      },
    );
  }
}
