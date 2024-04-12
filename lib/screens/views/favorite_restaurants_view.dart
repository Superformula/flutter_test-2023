import 'package:flutter/material.dart';
import 'package:restaurantour/widgets/restaurant_item_widget.dart';

class FavoriteRestaurantsView extends StatefulWidget {
  const FavoriteRestaurantsView({Key? key}) : super(key: key);

  @override
  State<FavoriteRestaurantsView> createState() =>
      _FavoriteRestaurantsViewState();
}

class _FavoriteRestaurantsViewState extends State<FavoriteRestaurantsView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100, top: 12),
      itemCount: 3,
      itemBuilder: (context, index) => const BuildRestaurantItem(),
    );
  }
}
