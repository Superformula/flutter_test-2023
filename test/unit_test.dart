import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/api/restaurant_service.dart';
import 'package:restaurantour/models/api_status.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'test_util.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  const baseUrl = 'https://api.yelp.com';
  const apiKey =
      'pFOpoemAaDeXkHTfJ1lxZXEL1MGobTl_TXm71fKyT4HfZm9Lw52jTR9Ko2Ds37yWsNz3vWWCO2gI8C1vbOy3SjEuL8ltOltuEaSHmCaRxoYM6TEcTGrN_uf0qcajYnYx';

  const restaurantKey = 'restaurantKey';

  setUp(() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/graphql'
        },
      ),
    );
    dioAdapter = DioAdapter(
      dio: dio,
      matcher: const FullHttpRequestMatcher(),
    );

    SharedPreferences.setMockInitialValues({});
  });

  group('app unit test', () {
    test('fetch Restaurant', () async {
      dioAdapter.onGet(
        baseUrl,
        (server) => server.reply(
          200,
          dioData,
          delay: const Duration(seconds: 1),
        ),
      );

      final response = await dio.get(baseUrl);

      print(response.data);
    });

    test('Restaurants data exists.', () async {
      Success data = TestUtil.restaurantData();
      if (data.response is RestaurantQueryResult) {
        RestaurantQueryResult queryResult =
            data.response as RestaurantQueryResult;
        List<Restaurant> restaurants = queryResult.restaurants!;

        expect(restaurants.length, 9);

        for (var element in restaurants) {
          print("Restaurant name is ${element.name ?? "No Name"}");
        }

        expect(restaurants.first.rating! < 0, false);
      }
    });

    test('local database test', () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      Success data = TestUtil.restaurantData();

      if (data.response is RestaurantQueryResult) {
        RestaurantQueryResult queryResult =
            data.response as RestaurantQueryResult;
        List<Restaurant> restaurants = queryResult.restaurants!;

        // save all of restaurant data to local DB
        pref.setString(restaurantKey, json.encode(restaurants));

        // load all of restaurant from local DB
        final restaurantList = pref.getString(restaurantKey);
        if (restaurantList != null) {
          // decode string
          final savedRestaurant = await json.decode(restaurantList);
          if (savedRestaurant != null && savedRestaurant.isNotEmpty) {
            // Convert List dynamic type to List<Restaurant>
            List<Restaurant> restaurantsFromDB =
                (savedRestaurant as List<dynamic>)
                    .map((e) => Restaurant.fromJson(e))
                    .toList();
            expect(restaurantsFromDB.length, 9);
            expect(restaurantsFromDB.first.rating! < 0, false);
          }
        }
      }
    });

    test('Restaurants failure with error', () async {
      Failure data = TestUtil.failRestaurant();
      if (data.response is int) {
        final code = data.response as int;
        expect(code, 400);

        String errorString = RestaurantService.errorMessage(code);
        print("Error string is $errorString");
      }
    });
  });
}

Map<String, dynamic> dioData = {
  "data": {
    "search": {
      "total": 1,
      "business": [
        {
          "id": "faPVqws-x-5k2CQKDNtHxw",
          "name": "Yardbird Southern Table & Bar",
          "price": "\$\$",
          "rating": 4.5,
          "photos": [
            "https:s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg"
          ],
          "reviews": [
            {
              "id": "sjZoO8wcK1NeGJFDk5i82Q",
              "rating": 5,
              "user": {
                "id": "BuBCkWFNT_O2dbSnBZvpoQ",
                "image_url":
                    "https:s3-media2.fl.yelpcdn.com/photo/v8tbTjYaFvkzh1d7iE-pcQ/o.jpg",
                "name": "Gina T."
              }
            },
            {
              "id": "okpO9hfpxQXssbTZTKq9hA",
              "rating": 5,
              "user": {
                "id": "0x9xu_b0Ct_6hG6jaxpztw",
                "image_url":
                    "https:s3-media3.fl.yelpcdn.com/photo/gjz8X6tqE3e4praK4HfCiA/o.jpg",
                "name": "Crystal L."
              }
            },
          ]
        }
      ]
    }
  }
};
