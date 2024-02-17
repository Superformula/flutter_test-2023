import 'package:flutter/material.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/features/home_page/presenter/page/widgets/all_restaurants_tab.dart';
import 'package:restaurantour/features/home_page/presenter/page/widgets/my_favorites_tab.dart';

class TabViews extends StatelessWidget {
  const TabViews(
      {super.key, required this.restaurantList, required this.favoriteList});

  final List<Restaurant> restaurantList;
  final List<Restaurant> favoriteList;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TabBarView(
        children: [
          AllRestaurantsTab(restaurantList: restaurantList),
          MyFavoritesTab(favoriteList: favoriteList),
        ],
      ),
    );
  }
}
