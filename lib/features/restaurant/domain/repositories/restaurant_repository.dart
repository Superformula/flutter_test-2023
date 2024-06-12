import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/data/local_restaurant_datasource.dart';
import 'package:restaurantour/features/restaurant/data/remote_restaurant_datasource.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants(int offset);
  Future<void> insertFavoriteRestaurants(Restaurant restaurant);
  Future<List<Restaurant>> getFavoriteRestaurants();
  Future<void> deleteFavoriteRestaurant(Restaurant restaurant);
}

class RestaurantRepositoryImpl extends RestaurantRepository {
  final _remoteRestaurantDataSource =
      GetIt.instance<RemoteRestaurantDataSource>();

  final _localRestaurantDataSource =
      GetIt.instance<LocalRestaurantDataSource>();

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

  @override
  Future<List<Restaurant>> getFavoriteRestaurants() =>
      _localRestaurantDataSource.getFavoriteRestaurants();

  @override
  Future<void> insertFavoriteRestaurants(Restaurant restaurant) =>
      _localRestaurantDataSource.insertFavoriteRestaurant(restaurant);

  @override
  Future<void> deleteFavoriteRestaurant(Restaurant restaurant) {
    return _localRestaurantDataSource.deleteFavoriteRestaurant(restaurant);
  }
}
