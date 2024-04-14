import 'package:get_it/get_it.dart';
import 'package:restaurantour/modules/home/data/repositories/yelp_repository.dart';
import 'package:restaurantour/modules/home/domain/controllers/details_restaurant_controller.dart';
import 'package:restaurantour/modules/home/domain/controllers/home_controller.dart';
import 'package:restaurantour/modules/home/domain/repositories/restaurant_repository_interface.dart';
import 'package:restaurantour/modules/home/domain/stores/favorite_store.dart';

import '../services/local_storage/local_storage.dart';
import '../services/local_storage/local_storage_interface.dart';

GetIt locator = GetIt.instance;

Future<void> setupServicesLocator() async {
  locator.registerSingleton<ILocalStorageService>(LocalStorageService());
  locator.registerLazySingleton<FavoriteStore>(() => FavoriteStore(locator.get<ILocalStorageService>()));
  locator.registerSingleton<IRestaurantRepository>(YelpRepository());
  locator.registerLazySingleton<HomeController>(
    () => HomeController(locator.get<FavoriteStore>(), locator.get<IRestaurantRepository>()),
  );
  locator.registerFactory<DetailsRestaurantController>(
    () => DetailsRestaurantController(locator.get<IRestaurantRepository>()),
  );
}
