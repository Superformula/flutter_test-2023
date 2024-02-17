import 'package:restaurantour/adapter/shared_preferences/shared_preferences_interface.dart';
import 'package:restaurantour/errors/not_found_exception.dart';

class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences);
  SharedPreferencesInterface sharedPreferences;

  Future<void> set(String key, String value) async {
    await sharedPreferences.set(key, value);
  }

  Future<String> get(String key) async {
    String? value = await sharedPreferences.get(key);
    if (value == null) {
      throw NotFoundException();
    }
    return value;
  }

  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }
}
