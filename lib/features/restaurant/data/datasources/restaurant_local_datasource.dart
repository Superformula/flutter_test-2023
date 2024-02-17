import 'package:shared_preferences/shared_preferences.dart';

class RestaurantLocalDatasource {
  final listId = 'restaurantsIds';

  Future<List<String>?> fetchFavoriteRestaurantsIds() async {
    final sharedPreferencesInstance = await _getSharedPreferencesInstance();

    return sharedPreferencesInstance.getStringList(listId);
  }

  Future<void> setFavoriteRestaurantsIds(
      List<String> restaurantsIdsList) async {
    final sharedPreferencesInstance = await _getSharedPreferencesInstance();

    await sharedPreferencesInstance.setStringList(listId, restaurantsIdsList);

    return;
  }

  Future<SharedPreferences> _getSharedPreferencesInstance() async =>
      await SharedPreferences.getInstance();
}
