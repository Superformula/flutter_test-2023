import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurantour/providers/favorite_restaurants_provider.dart';
import 'package:restaurantour/widgets/restaurant_item_widget.dart';

// This widget displays a list of favorite restaurants
class FavoriteRestaurantsView extends ConsumerWidget {
  const FavoriteRestaurantsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the current list of favorite restaurants from the provider
    final favoriteRestaurantsList = ref.watch(favoritesProvider);

    // Display a message if there are no favorite restaurants
    if (favoriteRestaurantsList.isEmpty) {
      return const Center(
        child: Text('No favorite restaurants yet'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100, top: 12),
      itemCount: favoriteRestaurantsList.length,
      // Build each restaurant item using BuildRestaurantItem widget
      itemBuilder: (context, index) => BuildRestaurantItem(
        restaurantData: favoriteRestaurantsList[index],
      ),
    );
  }
}
