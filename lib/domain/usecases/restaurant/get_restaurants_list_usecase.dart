import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/error/error.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/domain/repositories/repositories.dart';

@lazySingleton
class GetRestaurantsListUsecase
    extends Usecase<List<RestaurantEntity>, NoParams> {
  final RestaurantRepository _restaurantRepository;

  GetRestaurantsListUsecase({
    required RestaurantRepository restaurantRepository,
  }) : _restaurantRepository = restaurantRepository;

  @override
  Future<Either<Failure, List<RestaurantEntity>>> call({
    required NoParams params,
  }) async {
    return await _restaurantRepository.getRestaurantsList();
  }
}
