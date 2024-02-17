import 'package:dartz/dartz.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_local_datasource.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_remote_datasource.dart';
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
            ).toEntity().restaurants ??
            [],
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<List<String>> getFavoriteRestaurantsIds() async {
    final favoriteRestaurantsIds =
        await _restaurantLocalDatasource.fetchFavoriteRestaurantsIds() ?? [];

    return favoriteRestaurantsIds;
  }

  @override
  Future<void> setFavoriteRestaurantsIds({
    required List<String> favoriteRestaurantsIdsList,
  }) async {
    await _restaurantLocalDatasource
        .setFavoriteRestaurantsIds(favoriteRestaurantsIdsList);

    return;
  }
}
