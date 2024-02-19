abstract class SharedPreferencesInterface {
  Future<void> set(String key, String value);
  Future<void> remove(String key);
  Future<String?> get(String key);
}
