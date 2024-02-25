import 'dart:async';
import 'package:restaurantour/domain/core/core.dart';
import 'package:restaurantour/domain/restaurants/restaurants.dart';

typedef SetlistsResult<T> = Result<RestaurantsServiceException, T>;

abstract class RestaurantsServiceContract {
  FutureOr<SetlistsResult<List<RestaurantEntity>>> getRestaurants({
    int? page,
    int? itemsPerPage,
  });
}
