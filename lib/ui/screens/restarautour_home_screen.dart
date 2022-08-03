import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/bloc/restaurants/restaurants_bloc.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/ui/widgets/restaurant_list_tile.dart';

import '../../bloc/restaurants/restaurants_event.dart';
import '../../bloc/restaurants/restaurants_state.dart';
import '../widgets/all_restaurants_widget.dart';
import '../widgets/my_favorite_restaurants_widget.dart';
import 'restaurant_details_screen.dart';

class RestauranTourHomeScreen extends StatelessWidget {
  const RestauranTourHomeScreen({Key? key}) : super(key: key);

  static const titleStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'VelourRaw',
    fontWeight: FontWeight.w600,
  );

  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    const tabBar = TabBar(
      indicatorWeight: 2,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.black,
      labelColor: Colors.black,
      tabs: [
        Tab(text: 'All Restaurants'),
        Tab(text: 'My Favorites'),
      ],
    );

    var appBar = AppBar(
      backgroundColor: Colors.white,
      title: const Text('RestauranTour', style: titleStyle),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: tabBar,
        ),
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar,
        body: const TabBarView(
          children: [
            AllRestaurantsWidget(),
            MyFavoritesRestaurantsWidget(),
          ],
        ),
      ),
    );
  }
}
