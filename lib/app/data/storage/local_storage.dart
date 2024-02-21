abstract class LocalStorage {
  Future<void> saveData(String keyValue, String valueToCache);

  Future<String> fetchData(String keyValue);

  Future<void> saveList(String keyValue, List<String> listToCache);

  Future<List<String>> fetchListData(String keyValue);
}
