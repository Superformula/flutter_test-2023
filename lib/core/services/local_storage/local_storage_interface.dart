abstract class ILocalStorageService {
  Future<void> clear();

  Future<bool?> getBool(String key);

  Future<int?> getInt(String key);

  Future<double?> getDouble(String key);

  Future<String?> getString(String key);

  Future<void> setBool(String key, bool value);

  Future<void> setInt(String key, int? value);

  Future<void> setDouble(String key, double value);

  Future<void> setString(String key, String value);

  Future<void> remove(String key);

  Future<List<String>?> getStringList(String key);

  Future<void> setStringList(String key, List<String> value);
}
