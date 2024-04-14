import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/domain/repositories/restaurants_repository.dart';

class RestaurantsUsercase {
  final RestaurantsRepository repository;

  RestaurantsUsercase(this.repository);

  Future<RestaurantQueryResult?> call() async {
    return await repository.getRestaurants();
  }
}
