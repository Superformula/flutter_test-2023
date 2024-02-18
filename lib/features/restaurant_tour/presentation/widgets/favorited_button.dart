import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/features/restaurant_tour/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:restaurantour/features/restaurant_tour/models/restaurant.dart';
import 'package:restaurantour/theme/style.dart';

class FavoritedButton extends StatelessWidget {
  final Restaurant restaurant;
  const FavoritedButton(this.restaurant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoaded) {
          final bool isFav = state.favoritesRestaurants.any(
            (restaurantElement) => restaurantElement.id == restaurant.id,
          );

          return IconButton(
            icon: Icon(
              isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            ),
            color: isFav ? accentColor : defaultTextColor,
            onPressed: () {
              if (isFav) {
                BlocProvider.of<FavoritesBloc>(context)
                    .add(RemoveFavoriteRestaurantEvent(restaurant));
              } else {
                BlocProvider.of<FavoritesBloc>(context)
                    .add(SaveFavoriteRestaurantEvent(restaurant));
              }
            },
          );
        }
        return Container();
      },
    );
  }
}
