import 'package:flutter/foundation.dart';

class DataProvider extends ChangeNotifier {
  Future<String?> getRestaurants() async {
    try {
      var result = await getRestaurants();
      return null;
    } catch (error) {
      return error.toString();
    }
  }
}
