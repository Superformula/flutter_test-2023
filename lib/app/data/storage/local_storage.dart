abstract class LocalStorage {
  Future<void> saveData(String keyValue, String valueToCache);

  Future<String> fetchData(String keyValue);
}
