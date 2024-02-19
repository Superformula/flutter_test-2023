import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/rt_empty_widget.dart';
import 'package:restaurantour/components/rt_error_widget.dart';
import 'package:restaurantour/components/rt_item_widget.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/components/rt_shimmer_loading.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/features/restaurants/restaurants_view_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  RestaurantsViewModel? model;

  @override
  void initState() {
    super.initState();
    model = context.read();
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();

    if (model!.favoritesStatus.isLoading) return const RTShimmerLoading();

    if (model!.favoritesStatus.isError) return const RTErrorWidget();

    if (model!.favoritesStatus.isEmpty) return const RTEmptyWidget();

    return ListView.builder(
      itemCount: model!.favoritesRestaurantList.length,
      itemBuilder: (context, index) {
        final isFirstItem = index == 0;

        return RTItemWidget(
          key: Key('favorite-restaurant-$index'),
          isFirstItem: isFirstItem,
          imageNetwork: inject<RTImageNetwork>(),
          restaurant: model!.favoritesRestaurantList[index],
          onFinishNavigation: model!.loadFavorites,
        );
      },
    );
  }
}
