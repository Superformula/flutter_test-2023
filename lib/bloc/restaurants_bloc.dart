import 'package:bloc/bloc.dart';

import '../repositories/yelp_repository.dart';
import 'restaurants_state.dart';
import 'restaurants_event.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  RestaurantsBloc({required this.yelpRepository})
      : super(const RestaurantsLoading()) {
    on<RestaurantsStarted>(_onStarted);
    on<FetchedMoreRestaurants>(_fetchMoreRestaurants);
  }

  final YelpRepository yelpRepository;

  void _onStarted(
    RestaurantsStarted event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const RestaurantsLoading());

    try {
      final restaurant = await yelpRepository.getRestaurants();
      emit(
        RestaurantsLoaded(restaurant, 20),
      );
    } catch (_) {
      emit(RestaurantsFetchError());
    }
  }

  void _fetchMoreRestaurants(
    FetchedMoreRestaurants event,
    Emitter<RestaurantsState> emit,
  ) async {
    var state = this.state;

    if (state is RestaurantsLoaded) {
      emit(RestaurantsLoadedAndFetchingMore(state.restaurants, state.offSet));
      try {
        // Increment the offSet by 20.
        var newOffSet = state.offSet + 20;

        var newRestaurant = await yelpRepository.getRestaurants(
          offset: newOffSet,
        );

        emit(
          RestaurantsLoaded(
            [
              if (state.restaurants != null) ...state.restaurants!,
              if (newRestaurant != null) ...newRestaurant,
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
