import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/restaurant_repository.dart';

class DeleteFavoriteRestaurantUseCase {
  DeleteFavoriteRestaurantUseCase();

  final RestaurantRepository repository =
      GetIt.instance<RestaurantRepository>();

  Future<void> call(Restaurant restaurant) {
    return repository.deleteFavoriteRestaurant(restaurant);
  }
}
