import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurantour/providers/favorite_restaurants_provider.dart';
import 'package:restaurantour/widgets/restaurant_item_widget.dart';

class FavoriteRestaurantsView extends ConsumerWidget {
  const FavoriteRestaurantsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteRestaurantsList = ref.watch(favoritesProvider);

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100, top: 12),
      itemCount: favoriteRestaurantsList.length,
      itemBuilder: (context, index) => BuildRestaurantItem(
        restaurantData: favoriteRestaurantsList[index],
      ),
    );
  }
}
