import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/repositories/restaurant_repository.dart';

class FavoriteCubit extends Cubit<bool> {
  FavoriteCubit(
    this._repository, {
    required this.restaurantId,
  }) : super(false) {
    emit(_repository.checkFavoriteRestaurant(restaurantId));
  }

  final RestaurantRepository _repository;
  final String restaurantId;

  void setFavorite() {
    final favorite = _repository.favoriteRestaurant(
      restaurantId,
      favorite: !state,
    );
    emit(favorite);
  }
}
