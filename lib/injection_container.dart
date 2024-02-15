import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_remote_datasource.dart';
import 'package:restaurantour/features/restaurant/data/repositories/restaurant_repository.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_all_restaurants_usecases.dart';
import 'package:restaurantour/features/restaurant/presentation/cubit/all_restaurants_cubit.dart';

final dependency = GetIt.instance;

Future<void> init() async {
  dependency.registerFactory(
    () => AllRestaurantsCubit(
      getAllRestaurantsUseCase: dependency(),
    ),
  );

  dependency.registerFactory(
    () => RestaurantRemoteDatasource(),
  );

  dependency.registerFactory<IRestaurantRepository>(
    () => RestaurantRepository(
      restaurantRemoteDatasource: dependency(),
    ),
  );

  dependency.registerFactory(
    () => GetAllRestaurantsUseCase(
      restaurantRepository: dependency(),
    ),
  );
}
