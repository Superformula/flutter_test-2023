import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurantour/features/restaurant_tour/models/restaurant.dart';
import 'package:restaurantour/features/restaurant_tour/repositories/yelp_repository.dart';
import 'package:restaurantour/injection_container.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantLoading()) {
    on<LoadRestaurantsEvent>(_onLoadRestaurantEvent);
  }

  Future<FutureOr<void>> _onLoadRestaurantEvent(
    LoadRestaurantsEvent event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());
    try {
      RestaurantQueryResult? result =
          await sl<YelpRepository>().getRestaurants();
      if (result != null) {
        emit(RestaurantLoaded(restaurants: result.restaurants));
      } else {
        emit(RestaurantLoaded());
      }
    } catch (e) {
      // We could use here error messages from backend
      emit(
        RestaurantNotLoaded(
          error: 'Could not load the restaurants, please try again later',
        ),
      );
    }
  }
}
