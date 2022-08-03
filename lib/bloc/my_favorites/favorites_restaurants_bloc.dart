import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'favorites_restaurants_state.dart';
import 'favorites_restaurants_event.dart';

class FavoritesRestaurantsBloc
    extends HydratedBloc<FavoritesRestaurantsEvent, FavoritesRestaurantsState> {
  FavoritesRestaurantsBloc() : super(FavoritesRestaurantsState.empty) {
    on<AddFavoriteRestaurant>(_addFavoriteRestaurant);
    on<RemoveFavoriteRestaurant>(_removeFavoriteRestaurant);
  }

  @override
  FavoritesRestaurantsState? fromJson(Map<String, dynamic> json) =>
      FavoritesRestaurantsState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(FavoritesRestaurantsState state) =>
      state.toMap();

  void _addFavoriteRestaurant(
    AddFavoriteRestaurant event,
    Emitter<FavoritesRestaurantsState> emit,
  ) {
    emit(FavoritesRestaurantsState([...state.restaurants, event.restaurant]));
  }

  void _removeFavoriteRestaurant(
    RemoveFavoriteRestaurant event,
    Emitter<FavoritesRestaurantsState> emit,
  ) {
    var restaurants = List<Restaurant>.from(state.restaurants)
      ..removeWhere(
        (Restaurant restaurant) => restaurant.id == event.restaurant.id,
      );

    emit(FavoritesRestaurantsState(restaurants));
  }
}
