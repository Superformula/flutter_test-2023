part of 'restaurant_reviews_cubit.dart';

@immutable
abstract class RestaurantReviewsState {}

class RestaurantReviewsIdle extends RestaurantReviewsState {}

class RestaurantReviewsLoading extends RestaurantReviewsState {}

class RestaurantReviewsData extends RestaurantReviewsState {
  RestaurantReviewsData(this.reviewsList, this.reviewCount);
  final List<Review> reviewsList;
  final int reviewCount;
}

class RestaurantReviewsError extends RestaurantReviewsState {
  RestaurantReviewsError(this.errorMessage);
  final String errorMessage;
}
