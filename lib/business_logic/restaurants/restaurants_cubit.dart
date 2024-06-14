import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/yelp_repository.dart';
import 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit() : super(RestaurantsState());

  final yelpRepo = YelpRepository();

  Future<void> fetchRestaurants() async {
    emit(state.copyWith(status: RestaurantsStatus.loading));

    try {
      final result = await yelpRepo.getRestaurants();

      final isValidResult = result != null &&
          result.restaurants != null &&
          result.restaurants!.isNotEmpty;

      if (isValidResult) {
        emit(
          state.copyWith(
            status: RestaurantsStatus.success,
            restaurants: result!.restaurants,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: RestaurantsStatus.failure,
            errorMessage: 'An unexpected error occurred',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: RestaurantsStatus.failure,
          errorMessage: 'Failed to fetch restaurants: $e',
        ),
      );
    }
  }
}
