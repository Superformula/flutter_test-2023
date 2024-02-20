import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/core/routes.dart';
import 'package:restaurantour/core/rt_colors.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/core/rt_text_style.dart';
import 'package:restaurantour/features/restaurants/pages/favorites/favorites_page.dart';
import 'package:restaurantour/features/restaurants/pages/restaurants/restaurants_page.dart';
import 'package:restaurantour/features/restaurants/restaurants_view_model.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorite_service.dart';

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
