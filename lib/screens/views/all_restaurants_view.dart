import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurantour/providers/fetch_restaurants_provider.dart';
import 'package:restaurantour/widgets/restaurant_item_widget.dart';

class AllRestaurantsView extends ConsumerWidget {
  const AllRestaurantsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsState = ref.watch(restaurantsNotifierProvider);

    return restaurantsState.when(
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      error: (error, stack) =>
          const Center(child: Text('Error: No restaurants found')),
      data: (restaurants) {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 100, top: 12),
          itemCount: restaurants.length,
          itemBuilder: (context, index) => BuildRestaurantItem(
            restaurantData: restaurants[index],
          ),
        );
      },
    );
  }
}
