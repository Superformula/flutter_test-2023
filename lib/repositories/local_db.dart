
import 'package:restaurantour/repositories/key_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static final LocalDB instance = LocalDB._internal();

  LocalDB._internal();

  saveFavorite(String id,bool newFavorite) {
    _prefs.then((SharedPreferences prefs) {
      List<String>? favoriteList = prefs.getStringList(DBKey.favoriteList);

      if (favoriteList == null) {
        favoriteList = [];
        if (newFavorite) {
          favoriteList.add(id);
        }
      }else {
        if (newFavorite) {
          favoriteList.add(id);
        }else {
          favoriteList.removeWhere((element) => element == id);
        }
      }
      prefs.setStringList(DBKey.favoriteList, favoriteList);
    });
  }

  get favoriteList async => (await _prefs).getStringList(DBKey.favoriteList);

  isFavorite(String id) async {
    List<String>? favoriteList =  (await _prefs).getStringList(DBKey.favoriteList);
    if (favoriteList != null) {
      if(favoriteList.contains(id)) {
        return true;
      }
    }
    return false;
  }
}