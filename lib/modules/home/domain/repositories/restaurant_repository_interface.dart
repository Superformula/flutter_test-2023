import '../../data/models/response_model.dart';
import '../../data/models/restaurant.dart';

abstract class IRestaurantRepository {
  Future<ResponseModel<List<Restaurant>, Exception>> getRestaurants({int offset = 0});
  Future<ResponseModel<Restaurant, Exception>> getRestaurantById({required String id});
}
