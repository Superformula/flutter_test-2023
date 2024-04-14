import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurantour/constants/text_style_constants.dart';
import 'package:restaurantour/screens/views/all_restaurants_view.dart';
import 'package:restaurantour/screens/views/favorite_restaurants_view.dart';

class RestaurantListScreen extends ConsumerWidget {
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      // This controls the tab behavior (initial index, number of tabs)
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Configure app bar appearance
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Restaurantour',
            style: TextStylesClass.titleTextStyle,
          ),
          bottom: TabBar(
            // Configure tab layout and appearance
            tabAlignment: TabAlignment.center,
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'All Restaurants',
                  style: TextStylesClass.subtitlesTextStyle,
                ),
              ),
              Tab(
                child: Text(
                  'My Favorites',
                  style: TextStylesClass.subtitlesTextStyle,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            //All restaurants list view
            AllRestaurantsView(),
            //Favorite restaurants list view
            FavoriteRestaurantsView(),
          ],
        ),
      ),
    );
  }
}
