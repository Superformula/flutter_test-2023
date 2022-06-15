
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/repositories/local_db.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });

  group ('app unit test', () {
    test('restaurants count.', () async {
      final restaurants = await YelpRepository().getRestaurants();
      expect(restaurants?.restaurants?.isNotEmpty, true);
      expect(restaurants?.restaurants?.first.id?.isNotEmpty, true);
    });

    test('test local db save and fetch', () async {
      const String id = "userId";
      LocalDB db = LocalDB.instance;
      db.saveFavorite(id, true);

      final isFavorite = await db.isFavorite(id);
      expect(isFavorite, true);
    });
  });
}