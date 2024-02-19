import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorite_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

GetIt inject = GetIt.instance;

Future<void> setupInjection() async {
  await dotenv.load(fileName: ".env");

  final _apiKey = dotenv.env['API_KEY'];

  await inject.reset();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();

  inject.registerLazySingleton<Dio>(
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

  inject.registerLazySingleton<RestaurantRepository>(() => RestaurantRepository(dio: inject<Dio>()));

  inject.registerLazySingleton<SharedPreferences>(() => sharedPref);

  inject.registerLazySingleton<FavoriteService>(() => FavoriteService(sharedPreferences: inject<SharedPreferences>()));

  inject.registerLazySingleton<RTImageNetwork>(() => RTImageNetwork());
}
