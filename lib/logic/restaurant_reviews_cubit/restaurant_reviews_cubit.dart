import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';

part 'restaurant_reviews_state.dart';

class RestaurantReviewsCubit extends Cubit<RestaurantReviewsState> {
  final YelpRepository yelpRepository;

  RestaurantReviewsCubit({required this.yelpRepository})
      : super(RestaurantReviewsIdle());

  Future<List<Review>> loadReviews({
    required String restaurantId,
  }) async {
    emit(RestaurantReviewsLoading());

    try {
      final response = await yelpRepository.getRestaurantReviews(
        restaurantId: restaurantId,
      );
      emit(
        RestaurantReviewsData(
          response?.reviewsList ?? [],
          response?.total ?? 0,
        ),
      );
      return response?.reviewsList ?? [];
    } on DioException catch (error) {
      emit(RestaurantReviewsError(error.message ?? error.toString()));
    } catch (error) {
      emit(RestaurantReviewsError(error.toString()));
    } finally {
      emit(RestaurantReviewsIdle());
    }
    return [];
  }
}
