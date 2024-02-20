import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/providers/restaurantProvider.dart';
import 'package:restaurantour/widgets/home/allRestaurantTab.dart';
import 'package:restaurantour/widgets/home/myFavoritesTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    restaurantProvider.fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('RestauranTour'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Restaurants'),
              Tab(text: 'My Favorites'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllRestaurantsTab(),
            MyFavoritesTab(),
          ],
        ),
      ),
    );
  }
}
