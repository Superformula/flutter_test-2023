import 'package:flutter/foundation.dart';

import '../models/restaurant.dart';

class ListRestaurantsProvider with ChangeNotifier {
  List<Restaurant>? _restaurants;

  List<Restaurant>? get restaurants => _restaurants;

  void addRestaurants(List<Restaurant> list) {
    _restaurants = list;
    notifyListeners();
  }
}
