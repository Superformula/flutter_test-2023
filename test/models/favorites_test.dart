import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/models/favorites.dart';

void main() {
  group('Favorites', () {
    test('toJson should encode Favorites object to JSON string', () {
      final favorites = Favorites(ids: ['id1', 'id2', 'id3']);
      final jsonString = Favorites.toJson(favorites);
      expect(jsonString, '{"ids":["id1","id2","id3"]}');
    });

    test('fromJson should decode JSON string to Favorites object', () {
      const jsonString = '{"ids":["id1","id2","id3"]}';
      final favorites = Favorites.fromJson(jsonString);
      expect(favorites.ids, ['id1', 'id2', 'id3']);
    });
  });
}
