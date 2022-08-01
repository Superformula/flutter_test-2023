import 'package:bloc/bloc.dart';

import '../repositories/yelp_repository.dart';
import 'restaurants_state.dart';
import 'restaurants_event.dart';

class RestaurantsBloc extends Bloc<RestaurantEvent, RestaurantsState> {
  RestaurantsBloc({required this.yelpRepository})
      : super(RestaurantsLoading()) {
    on<RestaurantStarted>(_onStarted);
  }

  final YelpRepository yelpRepository;

  void _onStarted(
    RestaurantStarted event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(RestaurantsLoading());
    try {
      final restaurant = await yelpRepository.getRestaurants();
      emit(RestaurantsLoaded(restaurant));
    } catch (_) {
      emit(RestaurantsFetchError());
    }
  }
}
