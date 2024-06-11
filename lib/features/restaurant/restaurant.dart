import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:restaurantour/features/restaurant/data/local_restaurant_datasource.dart';
import 'package:restaurantour/features/restaurant/data/remote_restaurant_datasource.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/add_favorite_restaurant_use_case.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/delete_favorite_restaurant_use_case.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_favorites_restaurants_use_case.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_details_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/bloc/restaurant_list_cubit.dart';

export 'package:restaurantour/features/restaurant/presentation/restaurant_details/restaurant_details_page.dart';
export 'package:restaurantour/features/restaurant/presentation/restaurants_list/restaurant_list_page.dart';

final _getIt = GetIt.instance;

void initRestaurantDependecies() {
  _initHive();
  _initDataSources();
  _initRepositories();
  _initUseCases();
  _initBlocs();
}

void _initHive() {
  Hive
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(HoursAdapter())
    ..registerAdapter(UserAdapter())
    ..registerAdapter(RestaurantAdapter())
    ..registerAdapter(LocationAdapter());
  Hive.openBox<Restaurant>('favorite_restaurants');
}

void _initDataSources() {
  _getIt.registerFactory<RemoteRestaurantDataSource>(
    () => RemoteRestaurantDataSourceImpl(),
  );
  _getIt.registerFactory<LocalRestaurantDataSource>(
    () => LocalRestaurantDataSourceImpl(),
  );
}

void _initRepositories() {
  _getIt
      .registerFactory<RestaurantRepository>(() => RestaurantRepositoryImpl());
}

void _initUseCases() {
  _getIt.registerFactory<GetRestaurantsUseCase>(() => GetRestaurantsUseCase());
  _getIt.registerFactory<GetFavoriteRestaurantsUseCase>(
    () => GetFavoriteRestaurantsUseCase(),
  );
  _getIt.registerFactory<InsertFavoriteRestaurantUseCase>(
    () => InsertFavoriteRestaurantUseCase(),
  );
  _getIt.registerFactory<DeleteFavoriteRestaurantUseCase>(
    () => DeleteFavoriteRestaurantUseCase(),
  );
}

void _initBlocs() {
  _getIt.registerSingleton<RestaurantListCubit>(RestaurantListCubit());
  _getIt.registerSingleton<RestaurantDetailCubit>(RestaurantDetailCubit());
}
