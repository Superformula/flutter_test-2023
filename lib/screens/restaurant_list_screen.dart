import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/widgets/restaurant/favorite_restaurants_list.dart';
import 'package:superformula_flutter_test/widgets/restaurant/restaurants_list.dart';

class RestaurantListScreen extends StatefulWidget {
  static const String id = 'restaurant_list_screen';
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final List<Tab> tabs = [const Tab(text: "All Restaurants"), const Tab(text: "My Favorites")];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "RestauranTour",
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            isScrollable: true,
            tabs: tabs,
          ),
        ),
        body: const TabBarView(
          children: [
            RestaurantsList(),
            FavoriteRestaurantsList(),
          ],
        ),
      ),
    );
  }
}
