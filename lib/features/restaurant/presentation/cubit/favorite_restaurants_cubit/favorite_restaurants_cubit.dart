import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/add_favorite_restaurant_usecase.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/delete_favorite_restaurant_usecase.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_favorite_restaurants_usecase.dart';

part 'favorite_restaurants_state.dart';

class FavoriteRestaurantsCubit extends Cubit<FavoriteRestaurantsState> {
  FavoriteRestaurantsCubit({
    required GetFavoriteRestaurantsUseCase getFavoriteRestaurantsUseCase,
    required AddFavoriteRestaurantUseCase addFavoriteRestaurantUseCase,
    required DeleteFavoriteRestaurantUseCase deleteFavoriteRestaurantUseCase,
  })  : _getFavoriteRestaurantsUseCase = getFavoriteRestaurantsUseCase,
        _addFavoriteRestaurantUseCase = addFavoriteRestaurantUseCase,
        _deleteFavoriteRestaurantUseCase = deleteFavoriteRestaurantUseCase,
        super(FavoriteRestaurantsInitial());

  final GetFavoriteRestaurantsUseCase _getFavoriteRestaurantsUseCase;
  final AddFavoriteRestaurantUseCase _addFavoriteRestaurantUseCase;
  final DeleteFavoriteRestaurantUseCase _deleteFavoriteRestaurantUseCase;

  Future<void> loadFavoriteRestaurantsList() async {
    final favoriteRestaurantsList = await _getFavoriteRestaurantsUseCase();

    emit(
      FavoriteRestaurantsLoaded(restaurants: favoriteRestaurantsList),
    );
  }

  Future<void> addFavoriteRestaurant({
    required RestaurantEntity restaurant,
  }) async {
    final currentState = state;

    await _addFavoriteRestaurantUseCase(restaurant: restaurant);

    if (currentState is FavoriteRestaurantsLoaded) {
      emit(
        FavoriteRestaurantsLoaded(
          restaurants: [...currentState.restaurants, restaurant],
        ),
      );
    }
  }

  Future<void> deleteFavoriteRestaurant({
    required String? id,
  }) async {
    final currentState = state;

    await _deleteFavoriteRestaurantUseCase(id: id);

    if (currentState is FavoriteRestaurantsLoaded) {
      emit(
        FavoriteRestaurantsLoaded(
          restaurants: [...currentState.restaurants]
            ..removeWhere((restaurant) => restaurant.id == id),
        ),
      );
    }
  }
}
