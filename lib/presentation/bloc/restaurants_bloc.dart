import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/domain/usercases/restaurants_usercase.dart';
import 'package:restaurantour/domain/usercases/favorites_usercase.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final RestaurantsUsercase _restaurantsUsercase;
  final FavoritesUsercase _favoritesUsercase;

  RestaurantsBloc(this._restaurantsUsercase, this._favoritesUsercase)
      : super(RestaurantsEmpty()) {
    on<FetchRestaurants>(_onFetchRestaurants);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  /// Toggles the favorite status of a restaurant
  Future<void> _onToggleFavorite(event, emit) async {
    await _favoritesUsercase.toggleFavorite(event.id);
    final currentState = state;
    if (currentState is RestaurantsLoaded) {
      final restaurants = currentState.restaurants.map(
        (restaurant) {
          if (restaurant.id != event.id) return restaurant;
          return restaurant.copyWith(isFavorite: !restaurant.isFavorite!);
        },
      ).toList();
      emit(RestaurantsLoaded([...restaurants]));
    }
  }

  /// Fetches the list of restaurants
  Future<void> _onFetchRestaurants(event, emit) async {
    emit(RestaurantsLoading());

    final result = await _restaurantsUsercase.call();
    if (result != null) {
      final favs = await _favoritesUsercase.get();
      final restaurants = result.restaurants!
          .map((r) => r.copyWith(isFavorite: favs.contains(r.id)))
          .toList();
      emit(RestaurantsLoaded([...restaurants]));
    } else {
      emit(const RestaurantsError("Failed to fetch restaurants"));
    }
  }
}
