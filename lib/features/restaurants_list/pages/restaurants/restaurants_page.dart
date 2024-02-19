import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/rt_empty_widget.dart';
import 'package:restaurantour/components/rt_error_widget.dart';
import 'package:restaurantour/components/restaurant_item_widget.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/components/rt_shimmer_loading.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/features/restaurants_list/restaurant_list_view_model.dart';

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
    if (model!.restaurantListStatus.isLoading) return const RTShimmerLoading();

    if (model!.restaurantListStatus.isError) return const RTErrorWidget();

    if (model!.restaurantListStatus.isEmpty) return const RTEmptyWidget();

    return RefreshIndicator(
      onRefresh: () => model!.load(),
      child: ListView.builder(
        itemCount: model!.restaurants.length,
        itemBuilder: (context, index) {
          final isFirstItem = index == 0;

          return RestaurantItemWidget(
            key: Key('restaurant-$index'),
            isFirstItem: isFirstItem,
            imageNetwork: inject<RTImageNetwork>(),
            restaurant: model!.restaurants[index],
            onFinishNavigation: () => model!.loadFavorites(),
          );
        },
      ),
    );
  }
}
