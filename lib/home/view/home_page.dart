import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/l10n/l10n.dart';
import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static Route route() =>
      MaterialPageRoute(builder: (context) => const HomePage());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..loadAllRestaurants()
        ..loadFavorites(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key, this.initialIndex = 0}) : super(key: key);

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
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
                key: const Key('homeView_favoritesTab'),
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
