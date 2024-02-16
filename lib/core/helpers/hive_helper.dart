import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:restaurantour/core/models/restaurant.dart';

class HiveHelper {
  static final HiveHelper _singleton = HiveHelper._internal();
  late Box box;

  factory HiveHelper() {
    return _singleton;
  }

  HiveHelper._internal();

  Future<void> init() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    box = await Hive.openBox('favorites');
  }

  dynamic get(String key) {
    return box.get(key);
  }

  Future<void> put(String key, dynamic value) async {
    await box.put(key, value);
  }

  Future<void> delete(String key) async {
    await box.delete(key);
  }

  List<Restaurant> getAllRestaurants() {
    return box.values
        .map((e) => Restaurant.fromJson(e))
        .toList();
  }
}
