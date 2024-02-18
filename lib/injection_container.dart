import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant_tour/repositories/favorites_repository.dart';
import 'package:restaurantour/features/restaurant_tour/repositories/yelp_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repository
  sl.registerSingleton<YelpRepository>(YelpRepository());
  sl.registerSingleton<FavoritesRepository>(FavoritesRepository());

  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
}
