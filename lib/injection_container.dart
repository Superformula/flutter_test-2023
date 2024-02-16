import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_local_datasource.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_remote_datasource.dart';
import 'package:restaurantour/features/restaurant/data/repositories/restaurant_repository.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/add_favorite_restaurant_usecase.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/delete_favorite_restaurant_usecase.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_all_restaurants_usecases.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_favorite_restaurants_usecase.dart';
import 'package:restaurantour/features/restaurant/presentation/cubit/all_restaurants_cubit/all_restaurants_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/cubit/favorite_restaurants_cubit/favorite_restaurants_cubit.dart';

final dependency = GetIt.instance;

Future<void> init() async {
  dependency.registerFactory(
    () => AllRestaurantsCubit(
      getAllRestaurantsUseCase: dependency(),
    ),
  );

  dependency.registerFactory(
    () => FavoriteRestaurantsCubit(
      getFavoriteRestaurantsUseCase: dependency(),
      addFavoriteRestaurantUseCase: dependency(),
      deleteFavoriteRestaurantUseCase: dependency(),
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
    () => GetFavoriteRestaurantsUseCase(
      restaurantRepository: dependency(),
    ),
  );

  dependency.registerFactory(
    () => AddFavoriteRestaurantUseCase(
      restaurantRepository: dependency(),
    ),
  );

  dependency.registerFactory(
    () => DeleteFavoriteRestaurantUseCase(
      restaurantRepository: dependency(),
    ),
  );
}
