import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'package:restaurantour/modules/restaurant/view_models/restaurant_view_model.dart';

import 'MockYelpRepository.dart';

void main() {
  group('RestaurantViewModel Test', () {
    // Create a mock YelpRepository instance
    final mockYelpRepo = MockYelpRepository();
    final viewModel = RestaurantViewModel(yelpRepo: mockYelpRepo);

    test('fetchData returns a list of restaurants', () async {
      // Fetch data
      final restaurants = await viewModel.fetchAndCacheRestaurants();

      // Assert that a list of restaurants is returned
      expect(restaurants, isA<List<Restaurant>>());
      expect(restaurants.isNotEmpty, isTrue);
    });
  });
}
