import 'package:flutter/material.dart';

enum RestaurantDetailsStatus { loading, content, error, addingFavorite }

extension RestaurantDetailsStatusExt on RestaurantDetailsStatus {
  bool get isLoading => this == RestaurantDetailsStatus.loading;
  bool get isAddingFavorite => this == RestaurantDetailsStatus.addingFavorite;
  bool get isError => this == RestaurantDetailsStatus.error;
}

class RestaurantDetailsViewModel with ChangeNotifier {
  RestaurantDetailsStatus status = RestaurantDetailsStatus.loading;
  bool? isFavorite;

  RestaurantDetailsViewModel({this.isFavorite});
  void toggleFavorite() async {
    _emitChangingFavorite();
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    isFavorite = (isFavorite == null) ? true : !isFavorite!;
    _emitContent();
  }

  Future<void> load() async {
    try {
      _emitLoading();
      await Future<void>.delayed(const Duration(milliseconds: 1500));

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
    status = RestaurantDetailsStatus.addingFavorite;
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
