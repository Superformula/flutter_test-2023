import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/services/favorite_service.dart';

enum DetailsStatus { loading, content, error, updatingFavorite }

extension DetailsStatusExt on DetailsStatus {
  bool get isLoading => this == DetailsStatus.loading;
  bool get isAddingFavorite => this == DetailsStatus.updatingFavorite;
  bool get isError => this == DetailsStatus.error;
}

class DetailsViewModel with ChangeNotifier {
  DetailsStatus status = DetailsStatus.loading;
  bool isFavorite = false;
  Restaurant restaurant = Restaurant.fixture();
  final String restaurantId;
  final FavoriteService favoriteService;

  List<String> _favoriteList = [];

  DetailsViewModel({required this.favoriteService, required this.restaurantId});
  Future<void> toggleFavorite() async {
    try {
      _emitChangingFavorite();
      isFavorite ? await favoriteService.removeFavorite(restaurantId) : await favoriteService.addFavorite(restaurantId);

      isFavorite = !isFavorite;
    } catch (e) {
      print(e);
    } finally {
      _emitContent();
    }
  }

  Future<void> load() async {
    try {
      _emitLoading();

      _favoriteList = await favoriteService.loadFavorites();
      isFavorite = _favoriteList.contains(restaurantId);

      _emitContent();
    } catch (e) {
      print(e);
      _emitError();
    }
  }

  void _emitContent() {
    status = DetailsStatus.content;
    notifyListeners();
  }

  void _emitChangingFavorite() {
    status = DetailsStatus.updatingFavorite;
    notifyListeners();
  }

  void _emitLoading() {
    status = DetailsStatus.loading;
    notifyListeners();
  }

  void _emitError() {
    status = DetailsStatus.error;
    notifyListeners();
  }
}
