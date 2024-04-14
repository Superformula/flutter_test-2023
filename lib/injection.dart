// import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/data/datasources/local_data_source.dart';
import 'package:restaurantour/data/datasources/remote_data_source.dart';
import 'package:restaurantour/data/repositories/favorite_repository_impl.dart';
import 'package:restaurantour/data/repositories/restaurants_repository_impl.dart';
import 'package:restaurantour/domain/repositories/favorite_repository.dart';
import 'package:restaurantour/domain/repositories/restaurants_repository.dart';
import 'package:restaurantour/domain/usercases/restaurants_usercase.dart';
import 'package:restaurantour/domain/usercases/favorites_usercase.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => RestaurantsBloc(locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => RestaurantsUsercase(locator()));
  locator.registerLazySingleton(() => FavoritesUsercase(locator()));

  // repository
  locator.registerLazySingleton<RestaurantsRepository>(
    () => RestaurantsRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(localDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // external
  // locator.registerLazySingleton(() => Dio());
}
