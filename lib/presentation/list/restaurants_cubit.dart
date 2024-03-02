import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/restaurant_repository.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit(this._repository) : super(FetchingList()) {
    fetchRestaurants();
  }

  final RestaurantRepository _repository;

  Future<void> fetchRestaurants() async {
    emit(FetchingList());

    try {
      final restaurants = (await _repository.fetchRestaurants()) ?? [];
      if (restaurants.isEmpty) {
        emit(NoRestaurantsFound());
      } else {
        emit(RestaurantsList(restaurants: restaurants));
      }
    } catch (_) {
      emit(FailedToFetchRestaurants());
    }
  }
}

abstract class RestaurantsState {}

class FailedToFetchRestaurants extends RestaurantsState {}

class FetchingList extends RestaurantsState {}

class NoRestaurantsFound extends RestaurantsState {}

class RestaurantsList extends RestaurantsState {
  RestaurantsList({required this.restaurants});

  final List<Restaurant> restaurants;
}
