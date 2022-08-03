import 'package:bloc/bloc.dart';

import '../../repositories/yelp_repository.dart';
import 'restaurants_state.dart';
import 'restaurants_event.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  RestaurantsBloc({required this.yelpRepository})
      : super(const RestaurantsLoading()) {
    on<RestaurantsStarted>(_onStarted);
    on<FetchedMoreRestaurants>(_fetchMoreRestaurants);
  }

  static const howManyRestaurantsToFetch = 20;

  final YelpRepository yelpRepository;

  void _onStarted(
    RestaurantsStarted event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const RestaurantsLoading());

    try {
      final restaurant = await yelpRepository.getRestaurants();
      emit(
        RestaurantsLoaded(restaurant, howManyRestaurantsToFetch),
      );
    } catch (error) {
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
        var newOffSet = state.offSet + howManyRestaurantsToFetch;
        var newRestaurants = await yelpRepository.getRestaurants(
          offset: newOffSet,
        );

        emit(
          RestaurantsLoaded(
            [
              if (state.restaurants != null) ...state.restaurants!,
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
