import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorites_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt inject = GetIt.instance;

Future<void> setupInjection() async {
  const _apiKey = 'vssWzyNh4aMaf2s8z8jOVuVkDI1OERKDaPXgMIn0qYDNB_1DseUsTytTzRmQzlADj4b_S5XfkaR1Kv4N4SGwOtu8lH-0yaNze1M-KhBL8EIGVkOT55vGIRjnwfHQZXYx';

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

  inject.registerLazySingleton<FavoritesService>(() => FavoritesService(sharedPreferences: inject<SharedPreferences>()));

  inject.registerLazySingleton<RTImageNetwork>(() => RTImageNetwork());
}
