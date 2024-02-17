import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/rt_error_widget.dart';
import 'package:restaurantour/components/restaurant_item_widget.dart';
import 'package:restaurantour/features/restaurants_list/restaurant_view_model.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({super.key});

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  RestaurantListViewModel? model;

  @override
  void initState() {
    super.initState();
    model = context.read();
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();
    if (model!.status.isLoading) return const Center(child: CircularProgressIndicator());

    if (model!.status.isError) return const RTErrorWidget();

    return ListView.builder(
      itemCount: model!.restaurants.length,
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
