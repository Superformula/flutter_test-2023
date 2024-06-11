import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/add_favorite_restaurant_use_case.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/delete_favorite_restaurant_use_case.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_favorites_restaurants_use_case.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  RestaurantDetailCubit() : super(RestaurantDetailLoading());

  final getFavoriteRestaurantsUseCase =
      GetIt.instance<GetFavoriteRestaurantsUseCase>();
  final deleteFavoriteRestaurantsUseCase =
      GetIt.instance<DeleteFavoriteRestaurantUseCase>();
  final insertFavoriteRestaurantsUseCase =
      GetIt.instance<InsertFavoriteRestaurantUseCase>();

  void fetchRestaurantDetail(Restaurant restaurant) async {
    final favoritedRestaurantsList = await getFavoriteRestaurantsUseCase();
    emit(
      RestaurantDetailLoaded(
        isFavorited: favoritedRestaurantsList.contains(restaurant),
        restaurant: restaurant,
      ),
    );
  }

  void toggleFavorite() {
    final currentState = state;
    if (currentState is RestaurantDetailLoaded) {
      if (currentState.isFavorited) {
        deleteFavoriteRestaurantsUseCase(currentState.restaurant);
        emit(
          currentState.copyWith(
            isFavorited: false,
          ),
        );
      } else {
        insertFavoriteRestaurantsUseCase(currentState.restaurant);
        emit(
          currentState.copyWith(
            isFavorited: true,
          ),
        );
      }
    }
  }
}
