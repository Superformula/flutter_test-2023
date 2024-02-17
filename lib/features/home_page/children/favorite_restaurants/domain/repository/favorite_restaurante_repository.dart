import 'package:dio/dio.dart';
import 'package:oxidized/oxidized.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/restaurant_model.dart';

abstract class FavoriteRestaurantsRepository {
  Future<Result<RestaurantModel, DioException>> getRestaurantDetails({
    required String restaurantId,
  });
}
