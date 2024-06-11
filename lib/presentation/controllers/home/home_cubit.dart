import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/yelp_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final yelpRepo = YelpRepository();

  Future<void> fetchRestaurants() async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final result = await yelpRepo.getRestaurants();

      if (result != null) {
        emit(
          state.copyWith(
            status: HomeStatus.success,
            restaurants: result.restaurants,
          ),
        );
        print('Fetched ${result.restaurants!.length} restaurants');
      } else {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            errorMessage: 'An unexpected error occurred',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Failed to fetch restaurants: $e',
        ),
      );
    }
  }
}
