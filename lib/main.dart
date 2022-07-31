import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/bootstrap.dart';
import 'package:yelp_api/yelp_api.dart';

import 'app/app.dart';

const _apiKey =
    'pDNeXWJdee_Is0fwfrh9t1EmOzIbyz7szgdVqdA0RldPQt-mIw5X6P9upb6GhsKhX4qS4Usy5uo4o1ZxrUOzuYF_glOQw4G3V5Pew5fdEFgdOOfrIQJdhxHMZEi6YnYx';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dioClient = Dio(
    BaseOptions(
      baseUrl: 'https://api.yelp.com',
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/graphql'
      },
    ),
  );
  final restaurantRepository =
      RestaurantRepository(yelpApi: GraphQlYelpApiClient(dio: dioClient));

  bootstrap(() => App(restaurantRepository: restaurantRepository));
}
