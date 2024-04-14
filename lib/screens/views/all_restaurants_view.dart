import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurantour/providers/fetch_restaurants_provider.dart';
import 'package:restaurantour/widgets/restaurant_item_widget.dart';

// This widget displays a list of all restaurants
class AllRestaurantsView extends ConsumerWidget {
  const AllRestaurantsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the current state of the restaurantsNotifierProvider
    final restaurantsState = ref.watch(restaurantsNotifierProvider);

    return restaurantsState.when(
      // Handle loading state
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      // Handle error state
      error: (error, stack) =>
          const Center(child: Text('Error: No restaurants found')),
      // Handle data state and build the list
      data: (restaurants) {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 100, top: 12),
          itemCount: restaurants.length,
          // Build each restaurant item using BuildRestaurantItem widget
          itemBuilder: (context, index) => BuildRestaurantItem(
            restaurantData: restaurants[index],
          ),
        );
      },
    );
  }
}
