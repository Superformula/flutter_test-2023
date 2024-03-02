import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/restaurants/pages/favorites/favorites_page.dart';
import 'package:restaurantour/features/restaurants/pages/restaurants/restaurants_page.dart';
import 'package:restaurantour/features/restaurants/restaurants_view_model.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorite_service.dart';
import 'package:restaurantour/theme/theme.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});
  static RTRoute route = GoRouterConfig.home;

  static Widget create() => ChangeNotifierProvider(
        create: (context) => RestaurantsViewModel(
          favoritesService: inject<FavoriteService>(),
          restaurantRepository: inject<RestaurantRepository>(),
        ),
        child: const RestaurantsScreen(),
      );

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  RestaurantsViewModel? model;

  @override
  void initState() {
    super.initState();
    model = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await model!.load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 2,
            surfaceTintColor: RTColors.background,
            shadowColor: RTColors.primaryFill,
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
          body: const TabBarView(
            children: [
              RestaurantsPage(),
              FavoritesPage(),
            ],
          ),
        ),
      ),
    );
  }
}
