import 'package:restaurantour/domain/repositories/favorite_repository.dart';

class MockFavoriteRepository implements FavoriteRepository {
  final List<String> _favorites = [];

  @override
  Future<void> addFavorite(String id) {
    _favorites.add(id);
    return Future.value();
  }

  @override
  Future<List<String>> getFavorites() {
    return Future.value(_favorites);
  }

  @override
  Future<void> removeFavorite(String id) {
    _favorites.remove(id);
    return Future.value();
  }
}
