import 'package:hive_flutter/hive_flutter.dart';

import '../models/restaurant.dart';

class FavoritesManager {
  final favList = Hive.box<Restaurant>('favorites').listenable();

  void setUnsetFavorite(Restaurant item) async {
    final box = favList.value;
    final isFavorite = box.get(item.name) != null;

    if (isFavorite) {
      await box.delete(item.name);
    } else {
      await box.put(item.name, item);
    }
  }

  Future<List<Restaurant>> loadFavoritesList() async {
    return favList.value.values.toSet().toList();
  }
}
