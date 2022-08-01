import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/bloc/restaurants_bloc.dart';
import 'package:restaurantour/ui/widgets/restaurant_list_tile.dart';

import '../../bloc/restaurants_state.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('RestauranTour', style: titleStyle),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: TabBar(
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: [
                  Tab(text: 'All Restaurants'),
                  Tab(text: 'My Favorites'),
                ],
              ),
            ),
          ),
        ),
        // Listview with restaurant cards
        body: BlocBuilder<RestaurantsBloc, RestaurantsState>(
          builder: (context, state) {
            if (state is RestaurantsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            //
            else if (state is RestaurantsLoaded) {
              var restaurants = state.restaurants;

              if (restaurants == null || restaurants.isEmpty) {
                return const Center(child: Text('No restaurants found.'));
              }

              return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = restaurants[index];

                  return RestaurantListTile(
                    restaurant: restaurant,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetails(restaurant: restaurant),
                      ),
                    ),
                  );
                },
              );
            }
            //
            return const Center(child: Text('Something went wrong!'));
          },
        ),
      ),
    );
  }
}
