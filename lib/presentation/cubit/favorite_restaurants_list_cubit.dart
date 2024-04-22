import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/utils/status_enum.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/presentation/cubit/cubit.dart';

@singleton
class FavoriteRestaurantsCubit extends Cubit<FavoriteRestaurantsListState> {
  final List<RestaurantEntity> _favoriteRestaurants = [];

  FavoriteRestaurantsCubit() : super(_initialState());

  static FavoriteRestaurantsListState _initialState() {
    final List<RestaurantEntity> _favoriteRestaurants = [];
    return FavoriteRestaurantsListState(
      restaurantsList: const [],
      status:
          _favoriteRestaurants.isEmpty ? StatusEnum.empty : StatusEnum.success,
    );
  }

  void toggleFavorite(RestaurantEntity restaurant) {
    if (_favoriteRestaurants.contains(restaurant)) {
      _favoriteRestaurants.remove(restaurant);
    } else {
      _favoriteRestaurants.add(restaurant);
    }

    emit(
      state.copyWith(
        status: _favoriteRestaurants.isEmpty
            ? StatusEnum.empty
            : StatusEnum.success,
        restaurantsList: List<RestaurantEntity>.from(_favoriteRestaurants),
      ),
    );
  }
}
