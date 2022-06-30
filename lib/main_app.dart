import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/all_restaurants/all_restaurants_main.dart';
import 'package:restaurantour/my_favorites/my_favorites_main.dart';
import 'package:restaurantour/theme/app_color.dart';
import 'package:restaurantour/view_model/connectivity_model.dart';
import 'package:restaurantour/view_model/restaurant_model.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      // To set up tab text color
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    context.read<ConnectivityModel>().cancelSubscription();
  }

  @override
  Widget build(BuildContext context) {
    final connectionStatus =
        context.watch<ConnectivityModel>().connectionStatus;
    if (connectionStatus != null && connectionStatus == ConnectionState.none) {
      return const Scaffold(
        body: Center(child: Text("Please check your internet connection")),
      );
    }
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: SizedBox(
            // Set tab bar value with dynamic screen.
            width: MediaQuery.of(context).size.width * 0.72,
            child: TabBar(
              controller: _controller,
              tabs: [tabItem("All Restaurants", 0), tabItem("My Favorites", 1)],
            ),
          ),
        ),
        title: Center(
          child: Text(
            'RestauranTour',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        toolbarHeight: 90,
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          AllRestaurantsMain(),
          MyFavoritesMain(),
        ],
      ),
    );
  }

  Tab tabItem(String text, int index) {
    return Tab(
      child: Text(
        text,
        style: Theme.of(context).textTheme.button!.copyWith(
            color: _selectedIndex == index
                ? AppColor.defaultText
                : AppColor.secondaryText),
      ),
    );
  }
}
