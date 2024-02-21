import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:restaurantour/app/data/data_sources/resturants_local_data_source.dart';
import 'package:restaurantour/app/data/data_sources/resturants_remote_data_source.dart';
import 'package:restaurantour/app/data/repositories/restaurants_repository_impl.dart';
import 'package:restaurantour/app/data/services/network_info_service.dart';
import 'package:restaurantour/app/data/storage/local_storage.dart';
import 'package:restaurantour/app/data/storage/shared_preferences_adapter_impl.dart';
import 'package:restaurantour/app/interactor/repositories/restaurants_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

final _apiKey = dotenv.env['api_key'];

void setup() async {
  getIt.registerLazySingletonAsync(SharedPreferences.getInstance);
  getIt.registerLazySingleton<LocalStorage>(() => SharedPreferencesAdapterImpl());

  final dioBaseOptions = BaseOptions(
    baseUrl: 'https://api.yelp.com',
    headers: {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/graphql',
    },
  );

  getIt.registerSingleton<Dio>(Dio(dioBaseOptions));

  getIt.registerLazySingleton<RestaurantsRemoteDataSource>(
    () => YelpRestaurantsRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<RestaurantsLocalDataSource>(
    () => RestaurantsLocalDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<RestaurantsRepository>(
      () => RestaurantsRepositoryImpl(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton<InternetConnection>(() => InternetConnection());

  getIt.registerLazySingleton<NetworkInfoService>(
      () => NetworkInfoServiceInternetConnectionCheckerPlus(getIt()));
}
