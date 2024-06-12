import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/restaurant_repository.dart';

class InsertFavoriteRestaurantUseCase {
  final _repository = GetIt.instance<RestaurantRepository>();

  InsertFavoriteRestaurantUseCase();

  Future<void> call(Restaurant restaurant) async {
    return await _repository.insertFavoriteRestaurants(restaurant);
  }
}
