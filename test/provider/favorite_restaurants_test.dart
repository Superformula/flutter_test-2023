import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/providers/favorite_restaurants_provider.dart';

void main() {
  group('FavoritesNotifier', () {
    test('should add a restaurant to favorites when not already added', () {
      final container = ProviderContainer();
      final notifier = container.read(favoritesProvider.notifier);
      const testRestaurant = Restaurant(id: '1', name: 'Test Restaurant');

      notifier.addFavorite(testRestaurant);

      expect(
        container.read(favoritesProvider),
        contains(testRestaurant),
      );
    });

    test('should not add a duplicate restaurant to favorites', () {
      final container = ProviderContainer();
      final notifier = container.read(favoritesProvider.notifier);
      const testRestaurant = Restaurant(id: '1', name: 'Test Restaurant');

      notifier.addFavorite(testRestaurant);
      notifier.addFavorite(testRestaurant); // Attempt to add it again

      expect(
        container.read(favoritesProvider).length,
        1,
      );
    });

    test('should remove a restaurant from favorites', () {
      final container = ProviderContainer();
      final notifier = container.read(favoritesProvider.notifier);
      const testRestaurant = Restaurant(id: '1', name: 'Test Restaurant');

      notifier.addFavorite(testRestaurant);
      notifier.removeFavorite(testRestaurant);

      expect(
        container.read(favoritesProvider),
        isNot(
          contains(testRestaurant),
        ),
      );
    });
  });
}
