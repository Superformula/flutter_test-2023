import 'package:dartz/dartz.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_local_datasource.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_remote_datasource.dart';
import 'package:restaurantour/features/restaurant/data/models/restaurant_model.dart';
import 'package:restaurantour/features/restaurant/data/models/restaurant_query_result_model.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';

class RestaurantRepository implements IRestaurantRepository {
  RestaurantRepository({
    required RestaurantRemoteDatasource restaurantRemoteDatasource,
    required RestaurantLocalDatasource restaurantLocalDatasource,
  })  : _restaurantRemoteDatasource = restaurantRemoteDatasource,
        _restaurantLocalDatasource = restaurantLocalDatasource;

  final RestaurantRemoteDatasource _restaurantRemoteDatasource;
  final RestaurantLocalDatasource _restaurantLocalDatasource;

  @override
  Future<Either<String, List<RestaurantEntity>>> getAllRestaurants() async {
    try {
      final response = await _restaurantRemoteDatasource.fetchAllRestaurants();

      return Right(
        RestaurantQueryResultModel.fromJson(
              response.data!['data']['search'],
            ).restaurants ??
            [],
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<List<RestaurantEntity>> getFavoriteRestaurants() async {
    final List<RestaurantEntity> favoriteRestaurantsList = [];
    final favoriteRestaurantsRawData =
        await _restaurantLocalDatasource.fetchFavoriteRestaurants();

    favoriteRestaurantsRawData.forEach(
      (id, value) => favoriteRestaurantsList.add(
        RestaurantModel.fromJson(value),
      ),
    );

    return favoriteRestaurantsList;
  }

  @override
  Future<void> addFavoriteRestaurant({
    required RestaurantEntity restaurant,
  }) async {
    final newFavoriteRestaurant = RestaurantModel(
      id: restaurant.id,
      name: restaurant.name,
      price: restaurant.price,
      rating: restaurant.rating,
      photos: restaurant.photos,
      categories: restaurant.categories,
      hours: restaurant.hours,
      reviews: restaurant.reviews,
      location: restaurant.location,
    );

    await _restaurantLocalDatasource.addFavoriteRestaurant(
      restaurant.id,
      newFavoriteRestaurant.toJson(),
    );

    return;
  }

  @override
  Future<void> deleteFavoriteRestaurant({required String? id}) async {
    await _restaurantLocalDatasource.deleteFavoriteRestaurant(id);

    return;
  }
}
