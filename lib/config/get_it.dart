import 'package:get_it/get_it.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<YelpRepository>(YelpRepository());
}
