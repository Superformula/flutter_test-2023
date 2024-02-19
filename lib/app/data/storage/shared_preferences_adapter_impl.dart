import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/exceptions.dart';
import 'local_storage.dart';

class SharedPreferencesAdapterImpl implements LocalStorage {
  SharedPreferencesAdapterImpl();

  @override
  Future<void> saveData(String keyValue, String valueToCache) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyValue, valueToCache);
  }

  @override
  Future<String> fetchData(String keyValue) async {
    final prefs = await SharedPreferences.getInstance();
    final stringData = prefs.getString(keyValue);

    if (stringData != null) {
      return Future.value(stringData);
    } else {
      throw CacheException('Exception fetching data.');
    }
  }
}
