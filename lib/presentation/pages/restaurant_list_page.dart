import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';
import 'package:restaurantour/presentation/pages/restaurant_fav_list_page.dart';
import 'package:restaurantour/presentation/pages/widgets/custom_progress_indicator.dart';
import 'package:restaurantour/presentation/pages/widgets/restaurant_card.dart';
import 'package:restaurantour/presentation/pages/widgets/restaurant_list_widget.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  initState() {
    super.initState();
    context.read<RestaurantsBloc>().add(const OnRequestedRestaurants());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'RestauranTour',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.black,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              tabAlignment: TabAlignment.center,
              tabs: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'All Restaurants',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'My Favourites',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              RestaurantListWidget(),
              RestaurantFavListWidget(),
            ],
          ),),
    );
  }
}
