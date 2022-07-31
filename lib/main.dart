import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/bootstrap.dart';
import 'package:yelp_api/yelp_api.dart';

import 'app/app.dart';

const _apiKey =
    'iKPAvopXFyPGAPi6Ne_xc3PuphPXlpmu-NZWYzg5Ky76huLeKqEc_MACqoDbzZnUDQQ47hQo3MRqj6-w00T4SRK6gpfb5Uw-C3ZuMwfVDfzPwyfWznNMeCi72HPmYnYx';
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
