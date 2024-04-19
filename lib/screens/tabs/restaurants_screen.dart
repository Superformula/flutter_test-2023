import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/common/extensions.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/screens/restaurant_details/restaurant_details_screen.dart';
import 'package:restaurantour/screens/tabs/restaurant_item.dart';
import 'package:restaurantour/screens/tabs/tabs_vm.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({
    super.key,
    required this.restaurants,
    required this.loadStatus,
  });

  final List<Restaurant> restaurants;
  final LoadStatus loadStatus;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabsVM>(
      builder: (context, vm, _) {
        switch (loadStatus) {
          case LoadStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case LoadStatus.error:
            return Center(
              child: Text(
                "ERROR!",
                style: context.theme.textTheme.titleMedium,
              ),
            );
          case LoadStatus.loaded:
            return ListView.separated(
              itemCount: restaurants.length,
              padding: const EdgeInsets.only(
                top: 16,
                right: 8,
                left: 8,
                bottom: 36,
              ),
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];

                return RestaurantItem(
                  restaurant: restaurant,
                  onTap: () {
                    _openRestaurantDetails(context, restaurant, vm);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            );
        }
      },
    );
  }

  void _openRestaurantDetails(
      BuildContext context, Restaurant restaurant, TabsVM vm) async {
    await RestaurantDetails.push(context, restaurant);
    await vm.getFavoriteRestaurants();
    vm.forceNotifyListeners();
  }
}
