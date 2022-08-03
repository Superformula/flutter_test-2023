import 'package:bloc/bloc.dart';

import '../../repositories/yelp_repository.dart';
import 'restaurants_state.dart';
import 'restaurants_event.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  RestaurantsBloc({required this.yelpRepository})
      : super(const RestaurantsLoading()) {
    on<FetchedRestaurantsStarted>(_fetchedRestaurantsStarted);
    on<FetchedMoreRestaurants>(_fetchedMoreRestaurants);
  }

  static const howManyRestaurantsToFetch = 20;

  final YelpRepository yelpRepository;

  void _fetchedRestaurantsStarted(
    FetchedRestaurantsStarted event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const RestaurantsLoading());

    try {
      final restaurant = await yelpRepository.getRestaurants();
      if (restaurant == null) {
        emit(RestaurantsLoaded.empty);
      } else {
        emit(RestaurantsLoaded(restaurant, howManyRestaurantsToFetch));
      }
    } catch (error) {
      emit(RestaurantsFetchError());
    }
  }

  void _fetchedMoreRestaurants(
    FetchedMoreRestaurants event,
    Emitter<RestaurantsState> emit,
  ) async {
    var state = this.state;

    if (state is RestaurantsLoaded) {
      emit(RestaurantsLoadedAndFetchingMore(state.restaurants, state.offSet));
      try {
        var newOffSet = state.offSet + howManyRestaurantsToFetch;
        var newRestaurants = await yelpRepository.getRestaurants(
          offset: newOffSet,
        );

        emit(
          RestaurantsLoaded(
            [
              ...state.restaurants,
              if (newRestaurants != null) ...newRestaurants,
            ],
            newOffSet,
          ),
        );
      } catch (_) {
        emit(RestaurantsFetchError());
      }
    }
  }
}
