import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/restaurants/repositories/restaurant_repository.dart';

class GetRestaurantsUseCase {
  final RestaurantsRepository _restaurantsRepository;

  GetRestaurantsUseCase(this._restaurantsRepository);

  Future<List<RestaurantEntity>> call(int? offset) {
    return _restaurantsRepository.getRestaurants(offset ?? 0);
  }
}
