import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:restaurantour/core/services/local_storage/local_storage_interface.dart';
import 'package:restaurantour/core/utils/constants.dart';

import '../../data/models/restaurant.dart';
part 'favorite_store.g.dart';

class FavoriteStore = FavoriteStoreBase with _$FavoriteStore;

abstract class FavoriteStoreBase with Store {
  final ILocalStorageService _localStorage;
  FavoriteStoreBase(this._localStorage);

  // * Observables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls list of restaurants
  @observable
  ObservableList<Restaurant> restaurantsFavorits = ObservableList();

  // * Actions
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Gets all favorites restaurants
  Future<void> getFavorites() async {
    restaurantsFavorits.clear();
    final List<String> response = await _localStorage.getStringList(ConstantsApp.localFavorites) ?? [];
    if (response.isNotEmpty) {
      final List<Restaurant> data = response.map((element) => Restaurant.fromJson(jsonDecode(element))).toList();
      restaurantsFavorits.addAll(data);
    }
  }

  /// Adds a restaurant on list of favorites
  void addFavorite(Restaurant restaurant) {
    restaurantsFavorits.add(restaurant);
    _updateListFavorites();
  }

  /// Removes a restaurant on list of favorites
  void removeFavorite(Restaurant restaurant) {
    _localStorage.remove(restaurant.id!);
    restaurantsFavorits.removeWhere((element) => element.id == restaurant.id);
    _updateListFavorites();
  }

  /// Updates a list of favorites
  void _updateListFavorites() {
    final List<String> data = restaurantsFavorits.map((element) => jsonEncode(element.toJson())).toList();
    _localStorage.setStringList(ConstantsApp.localFavorites, data);
  }
}
