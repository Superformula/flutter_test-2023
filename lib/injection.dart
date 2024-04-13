import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/data/datasources/local_data_source.dart';
import 'package:restaurantour/data/datasources/remote_data_source.dart';
import 'package:restaurantour/data/repositories/restaurants_repository_impl.dart';
import 'package:restaurantour/domain/repositories/restaurants_repository.dart';
import 'package:restaurantour/domain/usercases/get_current_restaurants.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => RestaurantsBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentRestaurants(locator()));

  // repository
  locator.registerLazySingleton<RestaurantsRepository>(
    () => RestaurantsRepositoryImpl(remoteDataSource: locator()),
  );
  // data source
  locator.registerLazySingleton<RemoteDataSource>(() => LocalDataSourceImpl());

  // external
  locator.registerLazySingleton(() => Dio());
}
