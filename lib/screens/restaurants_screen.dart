import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/resources/resources_exports.dart';
import 'package:restaurantour/widgets/restaurant_tile.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  List<Restaurant>? _restaurants;

  Future<List<Restaurant>> _getRestaurants() async {
    final yelpRepo = YelpRepository();

    try {
      final result = await yelpRepo.getRestaurants();
      return result?.restaurants ?? [];
    } catch (e) {
      print('Failed to fetch restaurants: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appName),
          bottom: const TabBar(
            tabs: [
              Tab(text: AppStrings.allRestaurants),
              Tab(text: 'My Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First tab content
            FutureBuilder<List<Restaurant>>(
              future: _getRestaurants(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  _restaurants = snapshot.data;

                  if (_restaurants?.isEmpty ?? true) {
                    return const Center(child: Text(AppStrings.emptyList));
                  }

                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppPadding.padding8.h),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _restaurants?.length,
                        itemBuilder: (context, index) {
                          return RestaurantTile(restaurant: _restaurants![index]);
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text(AppStrings.noData));
                }
              },
            ),
            // Second tab content
            Container(),
          ],
        ),
      ),
    );
  }
}
