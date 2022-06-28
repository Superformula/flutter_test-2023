import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:restaurantour/api/restaurant_service.dart';
import 'package:restaurantour/models/api_status.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_util.dart';

@GenerateMocks([http.Client])
void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });

  group('app unit test', () {
    test('fetch Restaurant', () async {
      // final client = MockClient();
    });

    test('Restaurants data exists.', () async {
      Success data = TestUtil.restaurantData();
      if (data.response is RestaurantQueryResult) {
        RestaurantQueryResult queryResult =
            data.response as RestaurantQueryResult;
        List<Restaurant> restaurants = queryResult.restaurants!;

        expect(restaurants.length, 3);

        for (var element in restaurants) {
          print("Restaurant name is ${element.name ?? "No Name"}");
        }

        expect(restaurants.first.rating! < 0, false);
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
