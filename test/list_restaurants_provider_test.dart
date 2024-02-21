// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/application/list_restaurants_provider.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'package:restaurantour/repositories/yelp_repository.dart';

class MockYelpRepository extends Mock implements YelpRepository {}

void main() {
  late ListRestaurantsProvider provider;
  setUp(() {
    provider = ListRestaurantsProvider();
  });

  test('Initial values are correct', () async {
    expect(provider.restaurants, null);
    expect(provider.selectedRestaurantId, null);
    expect(provider.isLoading, false);
  });

  test('load restaurants to provider', () async {
    provider.addRestaurants(
        RestaurantQueryResult.fromJson({"total": 0, "business": []})
            .restaurants!);
    expect(provider.restaurants, []);
  });

  test('save selected restaurant id in provider', () async {
    provider.setCurrentRestaurant('1');
    expect(provider.selectedRestaurantId, '1');
  });
}
