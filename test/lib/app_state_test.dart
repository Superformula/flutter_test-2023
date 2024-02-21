import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/app_state.dart';

void main() {
  group('AppState', () {
    late AppState appState;

    setUp(() {
      appState = AppState();
    });

    test('favorites should be initially empty', () {
      expect(appState.favorites, isEmpty);
    });

    test('addFavorite should add a restaurant to favorites', () {
      const restaurant = Restaurant(id: '1', name: 'Restaurant A');
      appState.addFavorite(restaurant);
      expect(appState.favorites, contains(restaurant));
    });

    test('addFavorite should not add duplicate restaurants to favorites', () {
      const restaurant = Restaurant(id: '1', name: 'Restaurant A');
      appState.addFavorite(restaurant);
      appState.addFavorite(restaurant);
      expect(appState.favorites.length, 1);
    });

    test('removeFavorite should remove a restaurant from favorites', () {
      const restaurant = Restaurant(id: '1', name: 'Restaurant A');
      appState.addFavorite(restaurant);
      appState.removeFavorite(restaurant);
      expect(appState.favorites, isNot(contains(restaurant)));
    });

    test('isFavorite should return true for a restaurant in favorites', () {
      const restaurant = Restaurant(id: '1', name: 'Restaurant A');
      appState.addFavorite(restaurant);
      expect(appState.isFavorite(restaurant), isTrue);
    });

    test('isFavorite should return false for a restaurant not in favorites', () {
      const restaurant = Restaurant(id: '2', name: 'Restaurant B');
      expect(appState.isFavorite(restaurant), isFalse);
    });
  });
}
