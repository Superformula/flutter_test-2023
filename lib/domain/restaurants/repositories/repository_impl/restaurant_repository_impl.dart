import 'package:restaurantour/domain/exceptions/mapper_exception.dart';
import 'package:restaurantour/data/sources/yelp_source.dart';
import 'package:restaurantour/domain/restaurant_mapper.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/restaurants/repositories/repository_interfaces/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantsRepository {
  final YelpSource _yelpSource;
  RestaurantRepositoryImpl(this._yelpSource);

  @override
  Future<List<RestaurantEntity>> getRestaurants(int offset) async {
    // TODO(jvelezos): Remove this if clause to enable pagination
    if (offset > 45) {
      //wont call api to prevent exceeding limit
      return Future.value([]);
    }

    final result = await _yelpSource.getRestaurants(offset: offset);
    if (result == null) {
      throw Exception('Failed to fetch restaurants');
    }

    final restaurantEntities = RestaurantMapper.fromModelList(result);

    if (restaurantEntities.isEmpty) {
      throw MapperException('Failed to map restaurants');
    }

    return RestaurantMapper.fromModelList(result);
  }
}
