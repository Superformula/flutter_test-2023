import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/domain/entities/restaurant_details_entity.dart';
import 'package:restaurantour/domain/repositories/restaurant_details_repository.dart';

class GetRestaurantsUseCase {
  final RestaurantDetailsRepository restaurantsRepository;

  GetRestaurantsUseCase(this.restaurantsRepository);

  Future<Either<Failure,RestaurantDetailsEntity>> execute({required String id}){
    return restaurantsRepository.getRestaurantDetails(id: id);
  }

}