import 'package:flutter/material.dart';
import 'package:restaurantour/Modules/Home/view/all_restaurants_tab.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Text(
                    'All Restaurants',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'My Favorites',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            title: const Center(
              child: Text(
                'RestauranTour',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              AllRestaurantsTab(),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
