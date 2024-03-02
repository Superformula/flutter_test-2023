import 'package:get_it/get_it.dart';
import 'package:restaurantour/data/network/repositories/yelp_repository.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/view/restaurants/restaurant_list_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Use cases
  locator.registerFactory<GetRestaurantsUseCase>(
    () => GetRestaurantsUseCase(locator()),
  );

  // Repositories
  locator.registerLazySingleton<YelpRepository>(() => YelpRepository());

  // View Models
  locator.registerLazySingleton<RestaurantListViewModel>(
    () => RestaurantListViewModel(locator<GetRestaurantsUseCase>()),
  );
}
