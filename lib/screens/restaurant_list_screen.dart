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
          backgroundColor: Colors.white,
          title: Text(
            "RestauranTour",
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            isScrollable: true,
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
