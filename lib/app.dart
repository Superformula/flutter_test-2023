import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/pages/favorites_page.dart';
import 'package:restaurantour/presentation/pages/restaurants_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          initialIndex: 1,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'RestauranTour',
              ),
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    text: 'All Restaurants',
                  ),
                  Tab(
                    text: 'My Favorites',
                  ),
                ],
              ),
            ),
            body: const SafeArea(
              child: TabBarView(
                children: <Widget>[
                  RestaurantsPage(),
                  FavoritesPage(),
                ],
              ),
            ),
          ),
        ),
      );
}
