import 'package:flutter/material.dart';
import 'package:restaurantour/features/restauran_tour/view/all_restaurants_screen.dart';
import 'package:restaurantour/features/restauran_tour/view/my_favorites_screen.dart';
import 'package:restaurantour/theme/app_color.dart';

class RestauranTour extends StatelessWidget {
  const RestauranTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: AppColors.primaryFill,
            indicatorColor: AppColors.primaryFill,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: AppColors.secondaryText,
            labelStyle: Theme.of(context).textTheme.button,
            unselectedLabelStyle: Theme.of(context).textTheme.button,
            tabs: const [
              Tab(
                text: "All Resturants",
              ),
              Tab(
                text: "My Favorites",
              ),
            ],
          ),
          title: Text(
            "RestauranTour",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: const TabBarView(
          children: [
            AllRestaurantsScreen(),
            MyFavoritesScreen(),
          ],
        ),
      ),
    );
  }
}
