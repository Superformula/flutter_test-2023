import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_local_datasource.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_remote_datasource.dart';
import 'package:restaurantour/features/restaurant/data/repositories/restaurant_repository.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_all_restaurants_usecases.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_favorite_restaurants_ids_usecase.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/set_favorite_restaurants_ids_usecase.dart';
import 'package:restaurantour/features/restaurant/presentation/cubit/restaurants_cubit.dart';

final dependency = GetIt.instance;

Future<void> init() async {
  dependency.registerFactory(
    () => RestaurantsCubit(
      getAllRestaurantsUseCase: dependency(),
      getFavoriteRestaurantsIdsUseCase: dependency(),
      setFavoriteRestaurantsIdsUseCase: dependency(),
    ),
  );

  dependency.registerFactory(
    () => RestaurantRemoteDatasource(),
  );

  dependency.registerFactory(
    () => RestaurantLocalDatasource(),
  );

  dependency.registerFactory<IRestaurantRepository>(
    () => RestaurantRepository(
      restaurantRemoteDatasource: dependency(),
      restaurantLocalDatasource: dependency(),
    ),
  );

  dependency.registerFactory(
    () => GetAllRestaurantsUseCase(
      restaurantRepository: dependency(),
    ),
  );

  dependency.registerFactory(
    () => GetFavoriteRestaurantsIdsUseCase(
      restaurantRepository: dependency(),
    ),
  );

  dependency.registerFactory(
    () => SetFavoriteRestaurantsIdsUseCase(
      restaurantRepository: dependency(),
    ),
  );
}
