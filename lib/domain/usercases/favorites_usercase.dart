import 'package:restaurantour/domain/repositories/favorite_repository.dart';

class FavoritesUsercase {
  final FavoriteRepository _favoriteRepository;

  FavoritesUsercase(this._favoriteRepository);

  Future<List<String>> get() async {
    return await _favoriteRepository.getFavorites();
  }

  Future<bool> isFavorite(String id) async {
    final favorites = await get();
    return favorites.contains(id);
  }

  Future<void> toggleFavorite(String id) async {
    final isFavorite = await this.isFavorite(id);
    if (isFavorite) {
      await _favoriteRepository.removeFavorite(id);
    } else {
      await _favoriteRepository.addFavorite(id);
    }
  }
}
