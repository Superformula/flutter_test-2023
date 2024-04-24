import 'package:flutter/material.dart';
import 'package:restaurantour/widgets/restaurants_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              text: "All Restaurants",
            ),
            Tab(
              text: "My Favorites",
            ),
          ]),
          title: const Text("RestauranTour"),
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        body: TabBarView(
          children: [
            RestaurantsListWidget(),
            RestaurantsListWidget(
              favorites: true,
            ),
          ],
        ),
      ),
    );
  }
}
