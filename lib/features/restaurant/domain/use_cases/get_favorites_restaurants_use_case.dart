import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/restaurant_repository.dart';

class GetFavoriteRestaurantsUseCase {
  final _repository = GetIt.instance<RestaurantRepository>();

  GetFavoriteRestaurantsUseCase();

  Future<List<Restaurant>> call() async {
    return await _repository.getFavoriteRestaurants();
  }
}
