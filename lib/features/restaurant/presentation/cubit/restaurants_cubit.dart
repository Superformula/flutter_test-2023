import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_all_restaurants_usecases.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_favorite_restaurants_ids_usecase.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/set_favorite_restaurants_ids_usecase.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit({
    required GetAllRestaurantsUseCase getAllRestaurantsUseCase,
    required GetFavoriteRestaurantsIdsUseCase getFavoriteRestaurantsIdsUseCase,
    required SetFavoriteRestaurantsIdsUseCase setFavoriteRestaurantsIdsUseCase,
  })  : _getAllRestaurantsUseCase = getAllRestaurantsUseCase,
        _getFavoriteRestaurantsIdsUseCase = getFavoriteRestaurantsIdsUseCase,
        _setFavoriteRestaurantsIdsUseCase = setFavoriteRestaurantsIdsUseCase,
        super(RestaurantsInitial());

  final GetAllRestaurantsUseCase _getAllRestaurantsUseCase;
  final GetFavoriteRestaurantsIdsUseCase _getFavoriteRestaurantsIdsUseCase;
  final SetFavoriteRestaurantsIdsUseCase _setFavoriteRestaurantsIdsUseCase;

  Future<void> loadRestaurantsList() async {
    final resultAllRestaurants = await _getAllRestaurantsUseCase();
    final favoriteRestaurantsIds = await _getFavoriteRestaurantsIdsUseCase();

    resultAllRestaurants.fold(
      (errorMessage) => emit(
        RestaurantsError(errorMessage: errorMessage),
      ),
      (restaurants) => emit(
        RestaurantsLoaded(
          restaurants: restaurants,
          favoriteRestaurants: restaurants
              .where(
                (restaurant) => favoriteRestaurantsIds.contains(
                  restaurant.id,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Future<void> addFavoriteRestaurantId({required String? id}) async {
    final currentState = state;

    if (currentState is RestaurantsLoaded && id != null) {
      final newFavoriteRestaurants = [
        ...currentState.favoriteRestaurants,
        currentState.restaurants
            .where((restaurant) => restaurant.id == id)
            .first,
      ];

      _setRestaurantsLoadedState(
        restaurantsState: currentState,
        newFavoriteRestaurants: newFavoriteRestaurants,
      );
    }
  }

  Future<void> deleteFavoriteRestaurantId({required String? id}) async {
    final currentState = state;

    if (currentState is RestaurantsLoaded && id != null) {
      final newFavoriteRestaurants = [
        ...currentState.favoriteRestaurants,
      ]..remove(
          currentState.favoriteRestaurants
              .where((restaurant) => restaurant.id == id)
              .first,
        );

      _setRestaurantsLoadedState(
        restaurantsState: currentState,
        newFavoriteRestaurants: newFavoriteRestaurants,
      );
    }
  }

  Future<void> _setRestaurantsLoadedState({
    required RestaurantsLoaded restaurantsState,
    required List<RestaurantEntity> newFavoriteRestaurants,
  }) async {
    await _setFavoriteRestaurantsIdsUseCase(
      favoriteRestaurantIdsList: newFavoriteRestaurants
          .map((restaurant) => restaurant.id ?? "")
          .toList(),
    );
    emit(
      RestaurantsLoaded(
        restaurants: restaurantsState.restaurants,
        favoriteRestaurants: newFavoriteRestaurants,
      ),
    );
  }
}
