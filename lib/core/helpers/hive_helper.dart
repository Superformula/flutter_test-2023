import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveHelper {
  static final HiveHelper _singleton = HiveHelper._internal();
  late Box box;

  factory HiveHelper() => _singleton;

  HiveHelper._internal();

  Future<void> init() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    box = await Hive.openBox('favorites');
  }

  Future<void> addFavorite(String restaurantId) async {
    List<String> favorites = getAllFavoriteIds();
    if (!favorites.contains(restaurantId)) {
      favorites.add(restaurantId);
      await box.put('favoriteIds', favorites);
    }
  }

  Future<void> removeFavorite(String restaurantId) async {
    List<String> favorites = getAllFavoriteIds();
    favorites.remove(restaurantId);
    await box.put('favoriteIds', favorites);
  }

  List<String> getAllFavoriteIds() {
    return box.get('favoriteIds', defaultValue: <String>[])!.cast<String>();
  }
}
