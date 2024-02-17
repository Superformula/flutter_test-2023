import 'package:flutter/material.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/presentation/widgets/restaurant_item_widget.dart';

class RestaurantListWidget extends StatelessWidget {
  const RestaurantListWidget({
    Key? key,
    required this.restaurants,
    this.isFavoriteList = false,
  }) : super(key: key);

  static const noRestaurantsText = 'No restaurants were found.';
  static const noFavoriteRestaurantsText =
      'No favorite restaurants were found.';

  final List<RestaurantEntity> restaurants;
  final bool isFavoriteList;

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return Center(
        child: Text(
          isFavoriteList ? noFavoriteRestaurantsText : noRestaurantsText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index) => RestaurantItemWidget(
        restaurant: restaurants[index],
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: restaurants.length,
    );
  }
}
