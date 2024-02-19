import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/domain/entities/review_entity.dart';

abstract class ReviewsRepository {
    Future<Either<Failure,List<ReviewEntity>>> getReviewsList({required String id});

}