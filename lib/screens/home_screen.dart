import 'package:flutter/material.dart';

import '../widgets/all_restaurants_list.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Tab(text: "My  Favorites"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllRestaurantsList(),
            AllRestaurantsList(),
          ],
        ),
      ),
    );
  }
}
