import 'package:flutter/material.dart';

import '../widgets/restaurants_list.dart';

class RestaurantListScreen extends StatefulWidget {
  static const String id = 'restaurant_list_screen';
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("RestauranTour"),
          bottom: TabBar(
            tabs: [
              Tab(text: "All Restaurants"),
              Tab(text: "My Favorites"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RestaurantsList(),
            RestaurantsList(),
          ],
        ),
      ),
    );
  }
}
