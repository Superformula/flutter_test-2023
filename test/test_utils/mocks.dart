import 'package:mockito/annotations.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/watch_favorite_restaurants_use_case.dart';
import 'package:restaurantour/presentation/restaurants/restaurant_list/restaurant_list_view_model.dart';

@GenerateNiceMocks(
  [
    MockSpec<GetRestaurantsUseCase>(),
    MockSpec<WatchFavoriteRestaurantsUseCase>(),
    MockSpec<RestaurantListViewModel>(),
  ],
)
void main() {
  // ...
}
