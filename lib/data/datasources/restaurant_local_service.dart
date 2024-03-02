class RestaurantLocalService {
  final Map<String, bool> _storage = <String, bool>{};

  bool favoriteRestaurant(
    String id, {
    required bool favorite,
  }) {
    _storage[id] = favorite;
    return favorite;
  }

  bool checkFavoriteRestaurant(String id) {
    return _storage[id] ?? false;
  }
}
