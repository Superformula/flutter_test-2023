import 'package:flutter/material.dart';
import 'package:restaurantour/features/restauran_tour/model/restauran_service.dart';
import 'package:restaurantour/features/restauran_tour/model/restaurant.dart';
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
  int _totalRestaurants = 0;
  int _offSet = 0;
  late Restaurant _selectedRestaurant;

  late UserError _userError;

  bool get loading => _loading;
  List<Restaurant> get allRestaurants => _restaurantsList;
  int get totalRestaurantsCount => _totalRestaurants;
  Restaurant get selectedRestaurant => _selectedRestaurant;

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

  void getAllRestaurants({int offSet = 0}) async {
    setLoading(true);
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
    getAllRestaurants(offSet: _offSet);
  }

  void setSelectedRestaurant(Restaurant item) {
    _selectedRestaurant = item;
  }
}

class UserError {
  int? code;
  String? message;
  UserError({this.code, this.message});
}
