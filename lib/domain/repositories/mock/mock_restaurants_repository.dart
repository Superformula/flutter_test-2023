import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/domain/repositories/restaurants_repository.dart';

const mockRestaurants = <Restaurant>[
  Restaurant(id: '1', name: 'Restaurant 1'),
  Restaurant(id: '2', name: 'Restaurant 2'),
  Restaurant(id: '3', name: 'Restaurant 3'),
];

class MockRestaurantsRepository implements RestaurantsRepository {
  @override
  Future<RestaurantQueryResult?> getRestaurants() async {
    const result = RestaurantQueryResult(restaurants: mockRestaurants);
    return result;
  }
}
