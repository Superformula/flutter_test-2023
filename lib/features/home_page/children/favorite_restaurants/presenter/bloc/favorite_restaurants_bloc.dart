import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/restaurant_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/repository/favorite_restaurante_repository.dart';

part 'favorite_restaurants_event.dart';

part 'favorite_restaurants_state.dart';

class FavoriteRestaurantsBloc
    extends Bloc<FavoriteRestaurantsEvent, FavoriteRestaurantsState> {
  FavoriteRestaurantsBloc({
    required this.hiveHelper,
    required this.favoriteRestaurantsRepository,
  }) : super(FavoriteRestaurantsInitial()) {
    on<InitialEvent>(_onInitialEvent);
  }

  final HiveHelper hiveHelper;
  final FavoriteRestaurantsRepository favoriteRestaurantsRepository;

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<FavoriteRestaurantsState> emit,
  ) async {
    emit(const LoadingState());

    final favoriteList = hiveHelper.getAllFavoriteIds();
    List<RestaurantModel> favoriteRestaurants = [];

    if (favoriteList.isEmpty) {
      emit(const NoFavoritesState());
      return;
    }

    for (String restaurantId in favoriteList) {
      final response = await favoriteRestaurantsRepository.getRestaurantDetails(
        restaurantId: restaurantId,
      );

      response.when(
        ok: (restaurant) {
          favoriteRestaurants.add(restaurant);
        },
        err: (err) {
          print(err);
          return;
        },
      );
    }

    emit(FavoriteRestaurantsLoaded(favoriteList: favoriteRestaurants));
  }
}
