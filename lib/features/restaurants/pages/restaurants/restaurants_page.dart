import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/rt_empty_widget.dart';
import 'package:restaurantour/components/rt_error_widget.dart';
import 'package:restaurantour/components/rt_item_widget.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/components/rt_shimmer_loading.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/features/restaurants/restaurant_view_model.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({super.key});

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  RestaurantsViewModel? model;

  @override
  void initState() {
    super.initState();
    model = context.read();
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();
    if (model!.restaurantStatus.isLoading) return const RTShimmerLoading();

    if (model!.restaurantStatus.isError) return const RTErrorWidget();

    if (model!.restaurantStatus.isEmpty) return const RTEmptyWidget();

    return RefreshIndicator(
      onRefresh: () => model!.load(),
      child: ListView.builder(
        itemCount: model!.restaurantsList.length,
        itemBuilder: (context, index) {
          final isFirstItem = index == 0;

          return RTItemWidget(
            key: Key('restaurant-$index'),
            isFirstItem: isFirstItem,
            imageNetwork: inject<RTImageNetwork>(),
            restaurant: model!.restaurantsList[index],
            onFinishNavigation: () => model!.loadFavorites(),
          );
        },
      ),
    );
  }
}
