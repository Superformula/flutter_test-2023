import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/main.dart';
import 'package:restaurantour/managers/restaurants_manager.dart';
import 'package:restaurantour/models/restaurant.dart';

void main() {
  setUpAll(() {
    registerManagerHandlers();
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  test(
    'GIVEN an offset of 0 WHEN getRestaurants is called THEN response is RestaurantQueryResult',
    () async {
      // ARRANGE
      final rManager = RestaurantsManager();

      // ACT
      rManager.getRestaurants();

      // ASSERT
      expect(
        rManager.restaurantList.value,
        isInstanceOf<RestaurantQueryResult>(),
      );
    },
  );
}
