import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/repositories/restaurant_repository.dart';

class GetRestaurantsUseCase {
  final RestaurantsRepository restaurantsRepository;

  GetRestaurantsUseCase(this.restaurantsRepository);

  Future<Either<Failure,List<RestaurantEntity>>> execute({int offset = 0}){
    return restaurantsRepository.getRestaurantsList(offset: offset);
  }

}