import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';

final dependency = GetIt.instance;

const _apiKey = '<PUT YOUR API KEY HERE>';

void setupLocator() {
  dependency.registerLazySingleton<YelpRepository>(
    () => YelpRepository(),
  );

  dependency.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://api.yelp.com',
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/graphql',
        },
      ),
    ),
  );
}
