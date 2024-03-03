import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/data/sources/shared_preferences_source.dart';
import 'package:restaurantour/data/sources/yelp_source.dart';
import 'package:restaurantour/domain/restaurants/repositories/repository_impl/shared_preferences_repository_impl.dart';
import 'package:restaurantour/domain/restaurants/repositories/repository_impl/restaurant_repository_impl.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurant_favorite_status_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/toggle_favorite_restaurant_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/watch_favorite_restaurants_use_case.dart';
import 'package:restaurantour/presentation/restaurants/restaurant_detail/restaurant_detail_view_model.dart';
import 'package:restaurantour/presentation/restaurants/restaurant_list/restaurant_list_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Sources
  locator.registerLazySingleton<YelpSource>(() => YelpSource());
  locator.registerLazySingleton<SharedPreferencesSource>(
    () => SharedPreferencesSource(),
  );

  // Repositories
  locator.registerLazySingleton<RestaurantRepositoryImpl>(
    () => RestaurantRepositoryImpl(
      locator<YelpSource>(),
    ),
  );
  locator.registerLazySingleton<SharedPreferencesRepositoryImpl>(
    () => SharedPreferencesRepositoryImpl(
      locator<SharedPreferencesSource>(),
    ),
  );

  // UseCases
  locator.registerFactory<GetRestaurantsUseCase>(
    () => GetRestaurantsUseCase(
      locator<RestaurantRepositoryImpl>(),
    ),
  );
  locator.registerFactory<ToggleFavoriteRestaurantUseCase>(
    () => ToggleFavoriteRestaurantUseCase(
      locator<SharedPreferencesRepositoryImpl>(),
    ),
  );
  locator.registerFactory<WatchFavoriteRestaurantsUseCase>(
    () => WatchFavoriteRestaurantsUseCase(
      locator<SharedPreferencesRepositoryImpl>(),
    ),
  );
  locator.registerFactory(
    () => GetRestaurantFavoriteStatusUseCase(
      locator<SharedPreferencesRepositoryImpl>(),
    ),
  );

  // ViewModels
  locator.registerLazySingleton<RestaurantListViewModel>(
    () => RestaurantListViewModel(
      locator<GetRestaurantsUseCase>(),
      locator<WatchFavoriteRestaurantsUseCase>(),
    ),
  );
  locator.registerFactory<RestaurantDetailViewModel>(
    () => RestaurantDetailViewModel(
      locator<ToggleFavoriteRestaurantUseCase>(),
      locator<GetRestaurantFavoriteStatusUseCase>(),
    ),
  );
}

/// Regisers an object of type T
///
/// only available for testing
@visibleForTesting
void testRegister<T extends Object>(T object) {
  locator.registerSingleton<T>(object);
}
