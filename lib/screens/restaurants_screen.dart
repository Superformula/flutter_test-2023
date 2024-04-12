import 'package:flutter/material.dart';
import 'package:restaurantour/contants/text_style_constants.dart';
import 'package:restaurantour/screens/views/all_restaurants_view.dart';
import 'package:restaurantour/screens/views/favorite_restaurants_view.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Restaurantour',
            style: TextStylesClass.titleTextStyle,
          ),
          bottom: TabBar(
            onTap: (value) {
              //TODO: Login for the state provider
            },
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
