import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());

  Future<void> favoriteRestaurant(Restaurant restaurant) async {
    var newFavorites = List<Restaurant>.from(state.favorites);

    if (restaurant.id != null) {
      if (!state.favorites.contains(restaurant)) {
        newFavorites.add(restaurant);

        emit(
          state.copyWith(
            favorites: newFavorites,
            status: FavoriteStatus.success,
          ),
        );
        log('dummy list $newFavorites');
        log('state list ${state.favorites}');
      } else {
        newFavorites.remove(restaurant);

        emit(
          state.copyWith(
            favorites: newFavorites,
            status: FavoriteStatus.removed,
          ),
        );
        log('state list ${state.favorites}');
      }
    }
  }
}
