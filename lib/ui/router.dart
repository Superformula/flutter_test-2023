import 'package:go_router/go_router.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/ui/screens/screens.dart';

class RouteName {
  const RouteName._();

  static const home = 'home';
  static const restaurantDetails = 'restaurant_details';
}

final router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: RouteName.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/${RouteName.restaurantDetails}',
      name: RouteName.restaurantDetails,
      builder: (context, state) {
        return RestaurantDetailsScreen(restaurant: state.extra as Restaurant);
      },
    ),
  ],
);
