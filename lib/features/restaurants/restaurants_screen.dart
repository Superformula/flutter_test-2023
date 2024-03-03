import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/restaurants/pages/favorites/favorites_page.dart';
import 'package:restaurantour/features/restaurants/pages/favorites/favorites_page_view_model.dart';
import 'package:restaurantour/features/restaurants/pages/restaurants/restaurants_page.dart';
import 'package:restaurantour/features/restaurants/pages/restaurants/restaurants_page_view_model.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';
import 'package:restaurantour/theme/theme.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});
  static RTRoute route = GoRouterConfig.home;

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  RestaurantsViewModel? model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.restaurantListRestauranTour,
              style: RTTextStyle.headingH6(),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  key: const Key('all-restaurants-tab'),
                  child: Text(
                    AppLocalizations.of(context)!.restaurantListAllRestaurantsTab,
                    style: RTTextStyle.button(),
                  ),
                ),
                Tab(
                  key: const Key('my-favorites-tab'),
                  child: Text(
                    AppLocalizations.of(context)!.restaurantListMyFavoritesTab,
                    style: RTTextStyle.button(),
                  ),
                ),
              ],
            ),
          ),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => FavoritesViewModel(
                  eventBus: inject<EventBusService>(),
                  favoritesService: inject<FavoriteService>(),
                  restaurantRepository: inject<RestaurantRepository>(),
                ),
              ),
              ChangeNotifierProvider(
                create: (context) => RestaurantsViewModel(
                  restaurantRepository: inject<RestaurantRepository>(),
                ),
              ),
            ],
            child: const TabBarView(
              children: [
                RestaurantsPage(),
                FavoritesPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
