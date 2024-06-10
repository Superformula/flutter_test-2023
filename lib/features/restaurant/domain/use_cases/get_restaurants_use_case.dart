import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/restaurant_repository.dart';

class GetRestaurantsUseCase {
  final _repository = GetIt.instance<RestaurantRepository>();

  GetRestaurantsUseCase();

  Future<List<Restaurant>> call(int offset) async {
    return await _repository.getRestaurants(offset);
  }
}
