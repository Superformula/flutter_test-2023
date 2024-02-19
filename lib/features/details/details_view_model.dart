import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorite_service.dart';

enum DetailsStatus { loading, paginating, content, error, updatingFavorite }

extension DetailsStatusExt on DetailsStatus {
  bool get isLoading => this == DetailsStatus.loading;
  bool get isPaginating => this == DetailsStatus.paginating;
  bool get isAddingFavorite => this == DetailsStatus.updatingFavorite;
  bool get isError => this == DetailsStatus.error;
}

class DetailsViewModel with ChangeNotifier {
  DetailsStatus status = DetailsStatus.loading;
  bool isFavorite = false;
  Restaurant restaurant = const Restaurant();
  ReviewQueryResult? reviewsQuery;
  List<Review> reviews = [];

  final paginationSize = 20;
  final String restaurantId;
  final FavoriteService favoriteService;
  final RestaurantRepository restaurantRepository;

  List<String> _favoriteList = [];

  int get totalReviews => reviewsQuery?.total ?? 0;
  bool get shouldPaginate => reviews.length < totalReviews && totalReviews > paginationSize;

  DetailsViewModel({required this.favoriteService, required this.restaurantRepository, required this.restaurantId});
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
      await Future.wait([
        _getRestaurantDetails(),
        _getReviews(),
      ]);
      _favoriteList = await favoriteService.loadFavorites();
      isFavorite = _favoriteList.contains(restaurantId);
      _emitContent();
    } catch (e) {
      print(e);
      _emitError();
    }
  }

  Future<void> _getRestaurantDetails() async => restaurant = await restaurantRepository.getRestaurantDetails(restaurantId: restaurantId);
  Future<void> _getReviews() async {
    try {
      reviewsQuery = await restaurantRepository.getReviews(restaurantId: restaurantId);
      reviews.addAll(reviewsQuery?.review ?? []);
    } catch (e) {
      print(e);
    }
  }

  Future<void> paginateReviews() async {
    if (status.isPaginating || !shouldPaginate) return;
    try {
      _emitIsPaginating();
      final paginated = await restaurantRepository.getReviews(restaurantId: restaurantId, offset: reviews.length);
      reviews.addAll(paginated?.review ?? []);
    } catch (e) {
      print(e);
    } finally {
      _emitContent();
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

  void _emitIsPaginating() {
    status = DetailsStatus.paginating;
    notifyListeners();
  }
}
