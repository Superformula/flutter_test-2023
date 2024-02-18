import 'package:flutter/material.dart';
import 'package:restaurantour/services/favorites_service.dart';

enum RestaurantDetailsStatus { loading, content, error, updatingFavorite }

extension RestaurantDetailsStatusExt on RestaurantDetailsStatus {
  bool get isLoading => this == RestaurantDetailsStatus.loading;
  bool get isAddingFavorite => this == RestaurantDetailsStatus.updatingFavorite;
  bool get isError => this == RestaurantDetailsStatus.error;
}

class RestaurantDetailsViewModel with ChangeNotifier {
  RestaurantDetailsStatus status = RestaurantDetailsStatus.loading;
  final String restaurantId;
  final FavoritesService favoriteService;
  bool isFavorite = false;

  List<String> _favoriteList = [];

  RestaurantDetailsViewModel({required this.favoriteService, required this.restaurantId});
  Future<void> toggleFavorite() async {
    try {
      _emitChangingFavorite();
      await Future<void>.delayed(const Duration(milliseconds: 500));
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
      await Future<void>.delayed(const Duration(milliseconds: 300));

      _emitContent();
    } catch (e) {
      print(e);
      _emitError();
    }
  }

  void _emitContent() {
    status = RestaurantDetailsStatus.content;
    notifyListeners();
  }

  void _emitChangingFavorite() {
    status = RestaurantDetailsStatus.updatingFavorite;
    notifyListeners();
  }

  void _emitLoading() {
    status = RestaurantDetailsStatus.loading;
    notifyListeners();
  }

  void _emitError() {
    status = RestaurantDetailsStatus.error;
    notifyListeners();
  }
}
