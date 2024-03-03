import 'package:flutter/material.dart';
import 'package:restaurantour/core/logger.dart';
import 'package:restaurantour/models/dto.dart';
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
  RestaurantDto restaurant = const RestaurantDto();
  ReviewQueryResultDto? reviewsQuery;
  List<ReviewDto> reviews = [];

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
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to toggle favorite', exception: exception, stackTrace: stackTrace);
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
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to Load Restaurant Details', exception: exception, stackTrace: stackTrace);
      _emitError();
    }
  }

  Future<void> _getRestaurantDetails() async {
    try {
      restaurant = await restaurantRepository.getRestaurantDetails(restaurantId: restaurantId);
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to get Restaurant Details', exception: exception, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> _getReviews() async {
    try {
      reviewsQuery = await restaurantRepository.getReviews(restaurantId: restaurantId);
      reviews.addAll(reviewsQuery?.review ?? []);
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to get Restaurant Reviews', exception: exception, stackTrace: stackTrace);
    }
  }

  Future<void> paginateReviews() async {
    if (status.isPaginating || !shouldPaginate) return;
    try {
      _emitIsPaginating();
      final paginated = await restaurantRepository.getReviews(restaurantId: restaurantId, offset: reviews.length);
      reviews.addAll(paginated?.review ?? []);
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to paginate reviews', exception: exception, stackTrace: stackTrace);
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
