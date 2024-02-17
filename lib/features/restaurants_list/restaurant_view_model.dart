import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

enum RestaurantListStatus { loading, content, error }

extension RestaurantListStatusExt on RestaurantListStatus {
  bool get isLoading => this == RestaurantListStatus.loading;
  bool get isError => this == RestaurantListStatus.error;
}

class RestaurantListViewModel with ChangeNotifier {
  final YelpRepository yelpRepo;
  RestaurantListViewModel({required this.yelpRepo});

  RestaurantListStatus status = RestaurantListStatus.loading;
  RestaurantQueryResult? _restaurants;
  List<Restaurant> _favorites = [Restaurant.fixture()];

  List<Restaurant> get favorites => _favorites;
  List<Restaurant> get restaurants => _restaurants?.restaurants ?? [];

  Future<void> load() async {
    try {
      _emitLoading();
      _restaurants = await yelpRepo.getRestaurants();
      _emitContent();
    } catch (e) {
      _emitError();
    }
  }

  void _emitContent() {
    status = RestaurantListStatus.content;
    notifyListeners();
  }

  void _emitLoading() {
    status = RestaurantListStatus.loading;
    notifyListeners();
  }

  void _emitError() {
    status = RestaurantListStatus.error;
    notifyListeners();
  }
}
