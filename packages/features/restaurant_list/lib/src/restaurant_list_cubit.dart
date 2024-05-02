import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage/local_storage.dart';
import 'package:yelp_repository/yelp_repository.dart';

part 'restaurant_list_state.dart';

class RestaurantListCubit extends Cubit<RestaurantListState> {
  final YelpRepository _yelpRepository;
  final LocalStorage _localStorage;
  final int _pageSize = 20;

  RestaurantListCubit({
    required YelpRepository yelpRepository,
    required LocalStorage localStorage,
  })  : _yelpRepository = yelpRepository,
        _localStorage = localStorage,
        super(const RestaurantListState());

  Future<void> getRestaurants() async {
    try {
      final result = await _yelpRepository.getRestaurants(
        offset: state.pageIndex * _pageSize,
      );
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

  Stream<List<Restaurant>> get favoriteRestaurants =>
      _localStorage.restaurantListener;
}
