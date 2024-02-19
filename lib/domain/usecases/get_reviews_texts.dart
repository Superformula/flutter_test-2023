import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/domain/entities/restaurant_details_entity.dart';
import 'package:restaurantour/domain/entities/review_entity.dart';
import 'package:restaurantour/domain/repositories/restaurant_details_repository.dart';
import 'package:restaurantour/domain/repositories/review_repository.dart';

class GetRestaurantReviewsUseCase {
  final ReviewsRepository reviewsRepository;

  GetRestaurantReviewsUseCase(this.reviewsRepository);

  Future<Either<Failure,List<ReviewEntity>>> execute({required String id}){
    return reviewsRepository.getReviewsList(id: id);
  }

}