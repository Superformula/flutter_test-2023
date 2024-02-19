
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/data/data_source/restaurants_remote_data_source.dart';
import 'package:restaurantour/data/repositories/restaurant_details_repository_impl.dart';
import 'package:restaurantour/data/repositories/restaurants_repository_impl.dart';
import 'package:restaurantour/data/repositories/review_repository_impli.dart';
import 'package:restaurantour/domain/repositories/restaurant_details_repository.dart';
import 'package:restaurantour/domain/repositories/restaurant_repository.dart';
import 'package:restaurantour/domain/repositories/review_repository.dart';
import 'package:restaurantour/domain/usecases/get_restaurant_details.dart';
import 'package:restaurantour/domain/usecases/get_restaurants.dart';
import 'package:restaurantour/domain/usecases/get_reviews_texts.dart';
import 'package:restaurantour/presentation/bloc/favourite_restaurants_bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/reviews_bloc/reviews_bloc.dart';

final locator = GetIt.instance;

void setUpLocator() {
  //bloc
  locator.registerFactory(() => RestaurantsBloc(locator()));

  // usecase
  locator.registerFactory(() => GetRestaurantsUseCase(locator()));

  //repository
  locator.registerLazySingleton<RestaurantsRepository>(
    () => RestaurantsRepositoryImpl(restaurantsRemoteDataSource: locator()),
  );

  locator.registerLazySingleton<RestaurantsRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(dio: locator()),
  );

  locator.registerFactory(() => RestaurantDetailsBloc(locator()));

  
  locator.registerFactory(() => FavouriteRestaurantsBloc());


  // usecase
  locator.registerFactory(() => GetRestaurantDetailsUseCase(locator()));

  //repository
  locator.registerLazySingleton<RestaurantDetailsRepository>(
    () => RestaurantDetailsRepositoryImpl(restaurantsRemoteDataSource: locator()),
  );

      locator.registerFactory(() => ReviewBloc(locator()));

  // usecase
  locator.registerFactory(() => GetRestaurantReviewsUseCase(locator()));

  //repository
  locator.registerLazySingleton<ReviewsRepository>(
    () => ReviewRepositoryImpl(restaurantsRemoteDataSource: locator()),
  );

  locator.registerLazySingleton(() => Dio());
}
