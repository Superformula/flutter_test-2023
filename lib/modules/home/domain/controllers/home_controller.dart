import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobx/mobx.dart';
import 'package:restaurantour/core/enums/status_type_enum.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';
import 'package:restaurantour/modules/home/domain/stores/favorite_store.dart';

import '../repositories/restaurant_repository_interface.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final FavoriteStore _favoriteStore;
  final IRestaurantRepository _restaurantRepository;
  HomeControllerBase(this._favoriteStore, this._restaurantRepository);

  // * Controllers
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  final ScrollController scrollController = ScrollController();

  // * Variables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls paginação
  int pagination = -1;

  // * Observables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls status of page
  @observable
  StatusType status = StatusType.idle;

  /// Controls list of restaurants
  @observable
  ObservableList<Restaurant> restaurants = ObservableList();

  @computed
  List<Restaurant> get restaurantsFavorits => _favoriteStore.restaurantsFavorits;

  // * Actions
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Setup initial
  void loadingInfos() {
    _favoriteStore.getFavorites();
    _getRestaurants(refresh: true);
    scrollController.addListener(_scrollListener);
  }

  /// Gets all restaurants
  Future<void> _getRestaurants({bool refresh = false}) async {
    if (status.isLoadingActiveOrFinished) return;

    if (refresh) {
      pagination = 0;
      restaurants.clear();
    } else {
      pagination += 1;
    }

    status = restaurants.isEmpty ? StatusType.loading : StatusType.loadingMore;

    final result = await _restaurantRepository.getRestaurants(offset: pagination);

    if (result.isSuccess) {
      restaurants.addAll(result.data!);
      status = result.data!.isEmpty ? StatusType.finished : StatusType.success;
    } else {
      status = StatusType.failure;
    }
  }

  /// Listener on scroll page
  void _scrollListener() {
    if (scrollController.position.userScrollDirection == ScrollDirection.forward) return;

    final double triggerFetchMoreSize = 0.75 * scrollController.positions.last.maxScrollExtent;

    if (scrollController.position.pixels > triggerFetchMoreSize) _getRestaurants();
  }

  void dispose() {
    scrollController.dispose();
  }
}
