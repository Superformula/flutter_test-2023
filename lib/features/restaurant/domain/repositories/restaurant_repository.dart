import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/data/remote_restaurant_datasource.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants(int offset);
}

class RestaurantRepositoryImpl extends RestaurantRepository {
  final _remoteRestaurantDataSource =
      GetIt.instance<RemoteRestaurantDataSource>();

  RestaurantRepositoryImpl();

  @override
  Future<List<Restaurant>> getRestaurants(int offset) async {
    final response = await _remoteRestaurantDataSource.getRestaurants(offset);
    final List<Restaurant> restaurants = [];
    for (final business in response.data!['data']['search']['business']) {
      restaurants.add(Restaurant.fromJson(business));
    }
    return restaurants;
  }
}
