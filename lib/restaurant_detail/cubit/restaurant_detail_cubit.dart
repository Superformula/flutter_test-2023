import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  RestaurantDetailCubit({
    required Restaurant restaurant,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(RestaurantDetailState(restaurant: restaurant)) {
    _favoriteRestaurantsSubscription = _userRepository.favoriteRestaurants
        .listen(_onChangeFavoriteRestaurants);
  }
  final UserRepository _userRepository;
  late StreamSubscription<List<Restaurant>> _favoriteRestaurantsSubscription;

  @override
  Future<void> close() {
    _favoriteRestaurantsSubscription.cancel();
    return super.close();
  }

  void init() {
    final isFavorite = _userRepository.isFavorite(state.restaurant.id!);
    emit(state.copyWith(isFavorite: isFavorite));
  }

  void toggleFavorite() {
    final isFavorite = state.isFavorite;
    if (isFavorite) {
      _userRepository.removeFavoriteRestaurant(state.restaurant.id!);
    } else {
      _userRepository.addFavoriteRestaurant(state.restaurant);
    }
  }

  void _onChangeFavoriteRestaurants(List<Restaurant> favoriteRestaurants) {
    final isFavorite =
        favoriteRestaurants.any((element) => element.id == state.restaurant.id);
    emit(state.copyWith(isFavorite: isFavorite));
  }
}
