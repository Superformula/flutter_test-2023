import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/error/error.dart';
import 'package:restaurantour/core/http_service/http_service.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/data/models/models.dart';

abstract class RestaurantDatasource {
  Future<List<RestaurantModel>> getRestaurantsList();
}

@LazySingleton(as: RestaurantDatasource)
class RestaurantDatasourceImpl extends RestaurantDatasource {
  final HttpService _client;

  RestaurantDatasourceImpl({
    required HttpService client,
  }) : _client = client;

  @override
  Future<List<RestaurantModel>> getRestaurantsList() async {
    try {
      int offset = 0;
      final response = await _client.post<Map<String, dynamic>>(
        AppWords.endpoint,
        data: Queries.getQuery(offset),
      );
      final result =
          RestaurantQueryResultModel.fromJson(response['data']['search']);

      return Future.value(result.restaurantsModel);
    } catch (e) {
      throw RestaurantsListException(message: e.toString());
    }
  }
}
