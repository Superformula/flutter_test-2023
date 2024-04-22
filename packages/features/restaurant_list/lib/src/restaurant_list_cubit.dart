import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_repository/yelp_repository.dart';

part 'restaurant_list_state.dart';

class RestaurantListCubit extends Cubit<RestaurantListState> {
  final YelpRepository _yelpRepository;
  final int _pageSize = 20;

  RestaurantListCubit(YelpRepository yelpRepository)
      : _yelpRepository = yelpRepository,
        super(const RestaurantListState());

  Future<void> getRestaurants() async {
    try {
      final result = await _yelpRepository.getRestaurants(
        offset: state.pageIndex * _pageSize,
      );
      // TODO: Remove the restauratns that user has set as favorite
      emit(
        state.copyWith(
          pageStatus: PageStatus.success,
          pageIndex: state.pageIndex + 1,
          restaurants: result,
          isLastPage: result.length < _pageSize,
        ),
      );
    } catch (e) {
      emit(state.copyWith(pageStatus: PageStatus.error));
    }
  }
}
