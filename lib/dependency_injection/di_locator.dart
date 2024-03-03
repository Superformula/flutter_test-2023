import 'package:get_it/get_it.dart';
import 'package:restaurantour/data/sources/shared_preferences_repository.dart';
import 'package:restaurantour/data/sources/yelp_source.dart';
import 'package:restaurantour/domain/restaurants/repositories/repository_impl/shared_preferences_repository_impl.dart';
import 'package:restaurantour/domain/restaurants/repositories/repository_impl/restaurant_repository_impl.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/save_favorite_restaurant_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/watch_favorite_restaurants_use_case.dart';
import 'package:restaurantour/view/restaurants/restaurant_list/restaurant_list_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  // UseCases
  locator.registerFactory<GetRestaurantsUseCase>(
    () => GetRestaurantsUseCase(
      locator<RestaurantRepositoryImpl>(),
    ),
  );
  locator.registerFactory<SaveFavoriteRestaurantUseCase>(
    () => SaveFavoriteRestaurantUseCase(
      locator<SharedPreferencesRepositoryImpl>(),
    ),
  );
  locator.registerFactory<WatchFavoriteRestaurantsUseCase>(
    () => WatchFavoriteRestaurantsUseCase(
      locator<SharedPreferencesRepositoryImpl>(),
    ),
  );

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

  // ViewModels
  locator.registerLazySingleton<RestaurantListViewModel>(
    () => RestaurantListViewModel(
      locator<GetRestaurantsUseCase>(),
      locator<SaveFavoriteRestaurantUseCase>(),
      locator<WatchFavoriteRestaurantsUseCase>(),
    ),
  );
}
