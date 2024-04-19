import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/custom_widget/custom_app_bar.dart';
import 'package:restaurantour/screens/tabs/restaurants_screen.dart';
import 'package:restaurantour/screens/tabs/tabs_vm.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late final _vm = TabsVM();

  @override
  void initState() {
    _vm.getRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: getCustomAppBar(
            context,
            "RestauranTour",
            titleAlignment: Alignment.center,
            bottom: TabBar(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: const [
                Tab(
                  child: Text(
                    "All Restautants",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "My Favorites",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            color: Colors.grey.shade100,
            child: Consumer<TabsVM>(
              builder: (context, vm, _) {
                return TabBarView(
                  children: [
                    RestaurantsScreen(
                      loadStatus: vm.loadStatus,
                      restaurants: vm.restaurants,
                    ),
                    RestaurantsScreen(
                      loadStatus: vm.loadStatus,
                      restaurants: vm.favoriteRestaurants,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
