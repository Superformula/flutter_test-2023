import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/domain/core/core.dart';
import 'package:restaurantour/domain/restaurants/entities/entities.dart';
import 'package:restaurantour/domain/restaurants/exceptions/exceptions.dart';
import 'package:restaurantour/domain/restaurants/extensions/extensions.dart';
import 'package:restaurantour/domain/restaurants/service_contract/restaurants_service_contract.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

@Singleton(as: RestaurantsServiceContract)
class RestaurantsServiceLogic implements RestaurantsServiceContract {
  RestaurantsServiceLogic({
    required RestaurantsRepositoryContract restaurantsRepository,
  }) : _restaurantsRepository = restaurantsRepository;

  final RestaurantsRepositoryContract _restaurantsRepository;

  @override
  FutureOr<SetlistsResult<List<RestaurantEntity>>> getRestaurants({
    int? page,
    int? itemsPerPage,
  }) async {
    try {
      final restaurants = await _restaurantsRepository.getRestaurants(
        page: page,
        itemsPerPage: itemsPerPage,
      );
      return success(
          restaurants.map((restaurant) => restaurant.toEntity()).toList());
    } on ApiException catch (exception) {
      return error(
        RestaurantsServiceException(
          'Api exception: ${exception.error.toString()}',
        ),
      );
    } catch (exception, _) {
      return error(
        const RestaurantsServiceException(
          "An error has ocurred while trying to get the restaurants.",
        ),
      );
    }
  }
}
