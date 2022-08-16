import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:superformula_flutter_test/services/yelp_queries.dart';

import '../constants.dart';
import '../models/restaurant.dart';
import 'http_helper.dart';

class NetworkProvider {
  static final HttpHelper httpHelper = HttpHelper(baseUrl: kBaseUrl);

  static Future<RestaurantResult> fetchRestaurants({int offset = 0}) async {
    const String endpoint = '/v3/graphql';
    final Response response = await httpHelper.rawPost(endpoint, YelpQueries.getRestaurantsQuery(offset));
    log(jsonEncode(response.data).toString());
    return RestaurantResult.fromJson(response.data["data"]["search"]);
  }
}
