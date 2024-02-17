import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

GetIt inject = GetIt.instance;

Future<void> setupInjection() async {
  const _apiKey = 'AO8TkgbRdw0-6gxWaLeDx6s6OYsJaAhoN8_PuNREHCvccZWmqO1w1KiO63ted9E7lE6EHoAvslqtyl_fXcet39TiPkmnKVNzpUV51cyC0Tr5XxSQ1_BT4n0NN-XPZXYx';

  await inject.reset();

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

  inject.registerLazySingleton<YelpRepository>(() => YelpRepository(dio: inject<Dio>()));
}
