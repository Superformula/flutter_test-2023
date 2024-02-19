import 'package:restaurantour/adapter/shared_preferences/shared_preferences_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferencesAdapter implements SharedPreferencesInterface {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<String?> get(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  @override
  Future<void> remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }

  @override
  Future<void> set(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }
}
