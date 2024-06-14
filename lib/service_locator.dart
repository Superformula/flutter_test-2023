import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';

final dependency = GetIt.instance;

const _apiKey =
    'kRsfu6IYKBWwj5H0V_U976-VB1a-dZqkJCaDsQpT26aGyZFPGave0zUgTv7JV5feSecQEqsAmPy8YxdKes69J5M8sp-rErzHeljjS4vF6D9pfiP9enYsj2OqdIloZnYx';

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
