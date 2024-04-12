import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/domain/repositories/restaurants_repository.dart';

class GetCurrentRestaurants {
  final RestaurantsRepository repository;

  GetCurrentRestaurants(this.repository);

  Future<RestaurantQueryResult?> call() async {
    return await repository.getRestaurants();
  }
}
