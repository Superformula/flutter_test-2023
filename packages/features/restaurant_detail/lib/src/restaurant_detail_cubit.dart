import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage/local_storage.dart';
import 'package:yelp_repository/yelp_repository.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  final YelpRepository _yelpRepository;
  final LocalStorage _localStorage;
  final Restaurant _restaurant;
  final int _pageSize = 20;

  RestaurantDetailCubit({
    required YelpRepository yelpRepository,
    required LocalStorage localStorage,
    required Restaurant restaurant,
  })  : _yelpRepository = yelpRepository,
        _localStorage = localStorage,
        _restaurant = restaurant,
        super(const RestaurantDetailState());

  Future<void> getReviews() async {
    try {
      if (_restaurant.id == null) {
        throw Exception('Restaurant id is null');
      }
      final result = await _yelpRepository.getReviews(
        restaurantId: _restaurant.id!,
        offset: state.pageIndex * _pageSize,
      );
      emit(
        state.copyWith(
          pageStatus: PageStatus.success,
          pageIndex: state.pageIndex + 1,
          reviews: result,
          isLastPage: result.length < _pageSize,
        ),
      );
    } catch (e) {
      emit(state.copyWith(pageStatus: PageStatus.error));
    }
  }

  void addFavoriteRestaurant() {
    try {
      _localStorage.addRestaurant(_restaurant);
    } catch (e) {
      // log error at loging tool (firebase, new relic,...)
    }
  }

  void removeFavoriteRestaurant() {
    if (_restaurant.id != null) {
      final isRestaurantDeleted = _localStorage.removeRestaurant(
        _restaurant.id!,
      );
      if (!isRestaurantDeleted) {
        // log error at loging tool (firebase, new relic,...)
      }
    }
  }

  Stream<bool> get isFavoriteRestaurant =>
      _localStorage.containsRestaurantListener(_restaurant.id ?? '');
}
