import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurantour/contants/text_style_constants.dart';
import 'package:restaurantour/screens/views/all_restaurants_view.dart';
import 'package:restaurantour/screens/views/favorite_restaurants_view.dart';

class RestaurantListScreen extends ConsumerWidget {
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Restaurantour',
            style: TextStylesClass.titleTextStyle,
          ),
          bottom: TabBar(
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
            Center(
              child: AllRestaurantsView(),
            ),
            Center(
              child: FavoriteRestaurantsView(),
            ),
          ],
        ),
      ),
    );
  }
}
