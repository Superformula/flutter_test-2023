import 'package:flutter/material.dart';

import 'package:restaurantour/home/widgets/all_restaurants_list.dart';
import 'package:restaurantour/home/widgets/favorites_list.dart';
import 'package:restaurantour/l10n/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.homeAppBarTitle),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: l10n.homeAllRestaurantsTabBarText,
              ),
              Tab(
                text: l10n.homeFavoritesTabBarText,
              ),
            ],
            isScrollable: true,
          ),
        ),
        body: const TabBarView(
          children: [AllRestaurantList(), FavoritesList()],
        ),
      ),
    );
  }
}
