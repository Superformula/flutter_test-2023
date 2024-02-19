import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Home/tabs/all_restaurants_tab.dart';
import 'package:restaurantour/Modules/Home/tabs/my_favorites_tab/view/my_favorites_tab_injection.dart';
import 'package:restaurantour/Modules/Home/viewmodel/home_state.dart';
import 'package:restaurantour/Modules/Home/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeViewmodel homeViewmodel = BlocProvider.of<HomeViewmodel>(context);
    homeViewmodel.fetchRestaurants();

    return BlocBuilder<HomeViewmodel, HomeState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: const Tab(
                      child: Text(
                        'All Restaurants',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Tab(
                      child: Text(
                        'My Favorites',
                        style: TextStyle(color: Colors.black),
                      ),
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
            body: TabBarView(
              children: [
                AllRestaurantsTab(homeViewmodel: homeViewmodel),
                // Text('data1'),
                // Text('data'),
                MyFavoritesInjection(homeViewmodel: homeViewmodel),
              ],
            ),
          ),
        );
      },
    );
  }
}
