import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/rt_error_widget.dart';
import 'package:restaurantour/components/restaurant_item_widget.dart';
import 'package:restaurantour/features/restaurants_list/restaurant_view_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  RestaurantListViewModel? model;

  @override
  void initState() {
    super.initState();
    model = context.read();
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();

    if (model!.status.isError) return const RTErrorWidget();

    return ListView.builder(
      itemCount: model!.favorites.length,
      itemBuilder: (context, index) {
        final isFirstItem = index == 0;

        return RestaurantItemWidget(
          isFirstItem: isFirstItem,
          restaurant: model!.restaurants[index],
        );
      },
    );
  }
}
