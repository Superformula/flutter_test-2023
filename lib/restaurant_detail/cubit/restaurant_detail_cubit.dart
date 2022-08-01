import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailCubit extends Cubit<RestaurantDetailState> {
  RestaurantDetailCubit({
    required String restaurantId,
    required UserRepository userRepository,
    required RestaurantRepository restaurantRepository,
  })  : _userRepository = userRepository,
        _restaurantRepository = restaurantRepository,
        super(RestaurantDetailState(restaurantId: restaurantId)) {
    _favoriteRestaurantsSubscription = _userRepository.favoriteRestaurants
        .listen(_onChangeFavoriteRestaurants);
  }
  final RestaurantRepository _restaurantRepository;
  final UserRepository _userRepository;
  late StreamSubscription<List<Restaurant>> _favoriteRestaurantsSubscription;

  @override
  Future<void> close() {
    _favoriteRestaurantsSubscription.cancel();
    return super.close();
  }

  Future<void> init() async {
    try {
      final fullInformationRestaurant =
          await _restaurantRepository.getRestaurant(state.restaurantId);
      final isFavorite = _userRepository.isFavorite(state.restaurantId);
      emit(
        state.copyWith(
          isFavorite: isFavorite,
          restaurant: fullInformationRestaurant,
          status: RestaurantDetailStatus.loaded,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RestaurantDetailStatus.error));
    }
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
