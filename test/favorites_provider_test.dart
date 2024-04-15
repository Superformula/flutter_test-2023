import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/providers/favorites_helper.dart';

void main() {
  // test('favorites should increment length when adding one', () async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final favoritesProvider = FavoritesProvider();
  //   await favoritesProvider.addFavorite("120");
  //   expect(0, 1);
  // });

  test('favorites should decrease length when removing one', () async {
    WidgetsFlutterBinding.ensureInitialized();
    final favoritesProvider = FavoritesProvider();
    await favoritesProvider.addFavorite("120");
    await favoritesProvider.removeFavorite("120");
    expect(favoritesProvider.favorites.length, 0);
  });
}
