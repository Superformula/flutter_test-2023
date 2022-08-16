import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superformula_flutter_test/blocs/restaurants/restaurants_bloc.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';
import 'package:superformula_flutter_test/widgets/general/no_data_found_widget.dart';
import 'package:superformula_flutter_test/widgets/restaurant/restaurant_tile.dart';

class FavoriteRestaurantsList extends StatelessWidget {
  const FavoriteRestaurantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RestaurantsBloc restaurantsBloc = BlocProvider.of<RestaurantsBloc>(context);
    final List<Restaurant> favoriteRestaurants = restaurantsBloc.favoriteRestaurants;
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
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
