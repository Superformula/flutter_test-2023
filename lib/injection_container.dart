import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant_tour/repositories/yelp_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repository
  sl.registerSingleton<YelpRepository>(YelpRepository());
}
