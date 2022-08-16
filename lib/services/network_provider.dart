import 'package:dio/dio.dart';
import 'package:superformula_flutter_test/constants.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';
import 'package:superformula_flutter_test/services/http_helper.dart';
import 'package:superformula_flutter_test/services/yelp_queries.dart';

class NetworkProvider {
  static final HttpHelper httpHelper = HttpHelper(baseUrl: kBaseUrl);

  Future<RestaurantResult> fetchRestaurants({int offset = 0}) async {
    const String endpoint = '/v3/graphql';
    final Response response = await httpHelper.post(endpoint, YelpQueries.getRestaurantsQuery(offset));
    return RestaurantResult.fromJson(response.data["data"]["search"]);
  }
}
