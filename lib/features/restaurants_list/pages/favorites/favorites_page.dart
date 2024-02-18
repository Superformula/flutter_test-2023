import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/rt_empty_widget.dart';
import 'package:restaurantour/components/rt_error_widget.dart';
import 'package:restaurantour/components/restaurant_item_widget.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/components/rt_shimmer_loading.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/features/restaurants_list/restaurant_list_view_model.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async => await model!.loadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();

    if (model!.status.isLoading) return const RTShimmerLoading();

    if (model!.status.isFavoritesError) return const RTErrorWidget();

    if (model!.status.isFavoritesEmpty) return const RTEmptyWidget();

    return ListView.builder(
      itemCount: model!.favorites.length,
      itemBuilder: (context, index) {
        final isFirstItem = index == 0;

        return RestaurantItemWidget(
          key: Key('favorite-restaurant-$index'),
          isFirstItem: isFirstItem,
          imageNetwork: inject<RTImageNetwork>(),
          restaurant: model!.favorites[index],
          onFinishNavigation: model!.loadFavorites,
        );
      },
    );
  }
}
