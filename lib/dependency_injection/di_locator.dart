import 'package:get_it/get_it.dart';
import 'package:restaurantour/data/network/repositories/shared_preferences_repository.dart';
import 'package:restaurantour/data/network/repositories/yelp_repository.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/save_favorite_restaurant_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/watch_favorite_restaurants_use_case.dart';
import 'package:restaurantour/view/restaurants/restaurant_list_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  // UseCases
  locator.registerFactory<GetRestaurantsUseCase>(
    () => GetRestaurantsUseCase(
      locator<YelpRepository>(),
    ),
  );
  locator.registerFactory<SaveFavoriteRestaurantUseCase>(
    () => SaveFavoriteRestaurantUseCase(
      locator<SharedPreferencesRepository>(),
    ),
  );
  locator.registerFactory<WatchFavoriteRestaurantsUseCase>(
    () => WatchFavoriteRestaurantsUseCase(
      locator<SharedPreferencesRepository>(),
    ),
  );

  // Repositories
  locator.registerLazySingleton<YelpRepository>(() => YelpRepository());
  locator.registerLazySingleton<SharedPreferencesRepository>(
    () => SharedPreferencesRepository(),
  );

  // ViewModels
  locator.registerLazySingleton<RestaurantListViewModel>(
    () => RestaurantListViewModel(
      locator<GetRestaurantsUseCase>(),
      locator<SaveFavoriteRestaurantUseCase>(),
      locator<WatchFavoriteRestaurantsUseCase>(),
    ),
  );
}
