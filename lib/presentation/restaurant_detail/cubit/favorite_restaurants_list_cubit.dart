import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/utils/status_enum.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/presentation/restaurant_detail/cubit/cubit.dart';

@singleton
class FavoriteRestaurantsCubit extends Cubit<FavoriteRestaurantsListState> {
  final List<RestaurantEntity> _favoriteRestaurants = [];

  FavoriteRestaurantsCubit()
      : super(const FavoriteRestaurantsListState(restaurantsList: []));

  void toggleFavorite(RestaurantEntity restaurant) {
    if (_favoriteRestaurants.contains(restaurant)) {
      _favoriteRestaurants.remove(restaurant);
    } else {
      _favoriteRestaurants.add(restaurant);
    }
    emit(
      state.copyWith(
        status: StatusEnum.success,
        restaurantsList: List<RestaurantEntity>.from(_favoriteRestaurants),
      ),
    );
  }
}
