import 'package:flutter/material.dart';
import 'package:restaurantour/common/constants.dart';

import '../../restaurant/views/favorites_restaurants_list_view.dart';
import '../../restaurant/views/restaurants_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          tabAlignment: TabAlignment.center,
          tabs: const [
            Tab(
              text: Constants.allrestaurants,
            ),
            Tab(
              text: Constants.myFavorites,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [RestaurantsListView(), FavoritesRestaurantsListView()],
      ),
    );
  }
}
