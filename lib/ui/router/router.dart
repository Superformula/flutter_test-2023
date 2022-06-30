import 'package:go_router/go_router.dart';
import 'package:restaurantour/ui/models/restaurant_ui.dart';
import 'package:restaurantour/ui/views/views.dart';

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
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/${RouteName.restaurantDetails}',
      name: RouteName.restaurantDetails,
      builder: (context, state) {
        return RestaurantDetailsPage(
          restaurantUi: state.extra as RestaurantUi,
        );
      },
    ),
  ],
);
