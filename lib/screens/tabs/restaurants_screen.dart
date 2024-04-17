import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/common/extensions.dart';
import 'package:restaurantour/screens/restaurant_details/restaurant_details_screen.dart';
import 'package:restaurantour/screens/tabs/restaurant_item.dart';
import 'package:restaurantour/screens/tabs/tabs_vm.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabsVM>(
      builder: (context, vm, _) {
        switch (vm.loadStatus) {
          case LoadStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case LoadStatus.error:
            return Center(
              child: Text(
                "ERROR!",
                style: context.theme.textTheme.titleMedium,
              ),
            );
            break;
          case LoadStatus.loaded:
            return ListView.separated(
              itemCount: vm.restaurants.length,
              padding: const EdgeInsets.only(
                top: 16,
                right: 8,
                left: 8,
                bottom: 36,
              ),
              itemBuilder: (context, index) {
                final restaurant = vm.restaurants[index];

                return RestaurantItem(
                  restaurant: restaurant,
                  onTap: () {
                    RestaurantDetails.push(context);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            );
            break;
        }
      },
    );
  }
}
