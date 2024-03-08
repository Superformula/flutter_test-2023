import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/interceptor.dart';
import 'package:restaurantour/core/logger.dart';
import 'package:restaurantour/core/routes.dart';
import 'package:restaurantour/main.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt inject = GetIt.instance;

Future<void> setupInjection() async {
  RTLogger.i(message: 'Setup injection');

  String _apiKey = '';
  const String fileName = kIsProd ? '.env' : '.env_stage';

  try {
    await dotenv.load(fileName: fileName);
    _apiKey = dotenv.env['API_KEY'] ?? '';
    if (_apiKey.isEmpty) RTLogger.w(message: 'API_KEY is empty');
  } catch (exception) {
    RTLogger.e(message: 'Fail to load API_KEY, looking for $fileName file', exception: exception);
  }

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
    )..interceptors.add(LoggerInterceptor()),
  );

  inject.registerLazySingleton<RestaurantRepository>(() => RestaurantRepository(dio: inject<Dio>()));

  inject.registerLazySingleton<EventBusService>(() => EventBusService());

  inject.registerLazySingleton<SharedPreferences>(() => sharedPref);

  inject.registerLazySingleton<FavoriteService>(() => FavoriteService(sharedPreferences: inject<SharedPreferences>()));

  inject.registerLazySingleton<RTImageNetwork>(() => RTImageNetwork());

  inject.registerLazySingleton<GoRouterConfig>(() => GoRouterConfig());
}
