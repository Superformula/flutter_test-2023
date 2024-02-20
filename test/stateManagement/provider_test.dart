import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/providers/restaurantProvider.dart';

void main() {
  group('RestaurantProvider', () {
    test('fetchRestaurants should update restaurants list', () async {
      final restaurantProvider = RestaurantProvider();

      // Act
      await restaurantProvider.fetchRestaurants();

      // Assert
      expect(restaurantProvider.restaurants, isNotNull);
      expect(restaurantProvider.restaurants!.isNotEmpty, true);
    });
  });
}
