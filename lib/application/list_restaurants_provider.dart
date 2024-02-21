import 'package:flutter/foundation.dart';

import '../models/restaurant.dart';

class ListRestaurantsProvider with ChangeNotifier {
  List<Restaurant>? _restaurants;
  String? _selectedRestaurantId;
  bool _isLoading = false;

  List<Restaurant>? get restaurants => _restaurants;
  bool get isLoading => _isLoading;

  String? get selectedRestaurantId => _selectedRestaurantId;

  void addRestaurants(List<Restaurant> list) {
    _restaurants = list;
    notifyListeners();
  }

  void changeIsLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setCurrentRestaurant(String? r) {
    _selectedRestaurantId = r;
    notifyListeners();
  }
}
