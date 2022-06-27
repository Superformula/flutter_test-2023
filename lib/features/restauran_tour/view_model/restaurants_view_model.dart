import 'package:flutter/material.dart';
import 'package:restaurantour/features/restauran_tour/model/restauran_service.dart';
import 'package:restaurantour/features/restauran_tour/model/restaurant.dart';
import 'package:restaurantour/features/restauran_tour/view_model/user_error.dart';
import 'package:restaurantour/repositories/api_status.dart';

class RestaurantsViewModel extends ChangeNotifier {
  RestauranService? service;

  RestaurantsViewModel({
    RestauranService? service,
  }) {
    this.service = service ?? RestauranService();
    getAllRestaurants();
  }

  bool _loading = false;
  final List<Restaurant> _restaurantsList = [];
  final List<String> _favoriteList = [];
  int _totalRestaurants = 0;
  int _offSet = 0;
  late Restaurant _selectedRestaurant;
  late UserError _userError;

  /// Getting methods used to read the View model from Screen level
  bool get loading => _loading;
  List<Restaurant> get allRestaurants => _restaurantsList;
  int get totalRestaurantsCount => _totalRestaurants;
  Restaurant get selectedRestaurant => _selectedRestaurant;
  List<Restaurant> get favoriteRestaurants => getFavoriteList();
  UserError get userError => _userError;

  /// Setting methods to set to respective model objects based on user interactions.
  void setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  void setRestauransModel(RestaurantQueryResult result) {
    _restaurantsList.addAll(result.restaurants ?? []);
    _totalRestaurants = result.total ?? 0;
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void getAllRestaurants({int offSet = 0, bool isRefresh = true}) async {
    setLoading(isRefresh);
    var res = await service?.getAllRestaurans(offSet: offSet);
    if (res is Success<RestaurantQueryResult>) {
      setRestauransModel(res.response);
    }
    if (res is Failure) {
      UserError userError = UserError(
        code: res.code,
        message: res.errorResponse as String,
      );
      setUserError(userError);
    }
    setLoading(false);
  }

  void loadMore() {
    _offSet += 1;
    getAllRestaurants(offSet: _offSet, isRefresh: false);
  }

  void setSelectedRestaurant(Restaurant item) {
    _selectedRestaurant = item;
  }

  void addOrRemoveFavorite(String id) {
    if (_favoriteList.contains(id)) {
      _favoriteList.remove(id);
    } else {
      _favoriteList.add(id);
    }
    notifyListeners();
  }

  bool isFavorite() {
    return _favoriteList.contains(_selectedRestaurant.id);
  }

  List<Restaurant> getFavoriteList() {
    List<Restaurant> favoriteRestaurants = [];
    for (String id in _favoriteList) {
      Restaurant item = _restaurantsList.where((e) => e.id == id).first;
      favoriteRestaurants.add(item);
    }
    return favoriteRestaurants;
  }
}
