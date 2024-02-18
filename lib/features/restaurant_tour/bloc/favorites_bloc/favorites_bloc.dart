import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurantour/core/resources/helper.dart';
import 'package:restaurantour/features/restaurant_tour/models/restaurant.dart';
import 'package:restaurantour/features/restaurant_tour/repositories/favorites_repository.dart';
import 'package:restaurantour/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesLoading()) {
    on<LoadFavoritesEvent>(_onLoadRestaurantEvent);
    on<SaveFavoriteRestaurantEvent>(_onSaveFavoriteRestaurantEvent);
    on<RemoveFavoriteRestaurantEvent>(_onRemoveFavoriteRestaurantEvent);
  }

  FutureOr<void> _onLoadRestaurantEvent(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) {
    emit(FavoritesLoading());
    try {
      final List<Restaurant> favoritesRestaurants =
          sl<FavoritesRepository>().loadFavorites();

      emit(FavoritesLoaded(favoritesRestaurants: favoritesRestaurants));
    } catch (e) {
      emit(
        FavoritesNotLoaded(
          error:
              'Could not load your favorite restaurants, please try again later',
        ),
      );
    }
  }

  Future<FutureOr<void>> _onSaveFavoriteRestaurantEvent(
    SaveFavoriteRestaurantEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is FavoritesLoaded) {
      final List<Restaurant> favoritesRestaurants =
          (state as FavoritesLoaded).favoritesRestaurants;

      emit(FavoritesLoading());
      try {
        favoritesRestaurants.add(event.restaurant);

        List<String> favoriteStrings = favoritesRestaurants
            .map((restaurant) => json.encode(restaurant.toJson()))
            .toList();

        await sl<SharedPreferences>()
            .setStringList('favoritesList', favoriteStrings);

        showToast('Restaurant favorited successfully');

        emit(FavoritesLoaded(favoritesRestaurants: favoritesRestaurants));
      } catch (e) {
        showToast(
          'Could not save your favorite restaurants, please try again later',
          error: true,
        );
      }
    }
  }

  Future<FutureOr<void>> _onRemoveFavoriteRestaurantEvent(
    RemoveFavoriteRestaurantEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is FavoritesLoaded) {
      final List<Restaurant> favoritesRestaurants =
          (state as FavoritesLoaded).favoritesRestaurants;

      emit(FavoritesLoading());
      try {
        favoritesRestaurants
            .removeWhere((element) => element.id == event.restaurant.id);

        List<String> favoriteStrings = favoritesRestaurants
            .map((restaurant) => json.encode(restaurant.toJson()))
            .toList();

        await sl<SharedPreferences>()
            .setStringList('favoritesList', favoriteStrings);

        showToast('Restaurant removed successfully');

        emit(FavoritesLoaded(favoritesRestaurants: favoritesRestaurants));
      } catch (e) {
        showToast(
          'Could not remove your favorite restaurants, please try again later',
          error: true,
        );
      }
    }
  }
}
