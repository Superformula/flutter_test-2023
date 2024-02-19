import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/features/details/details_screen.dart';
import 'package:restaurantour/features/restaurants/restaurants_view_model.dart';

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
    if (model!.restaurantsStatus.isLoading) return const RTShimmerLoading();

    if (model!.restaurantsStatus.isError) return const RTErrorWidget();

    if (model!.restaurantsStatus.isEmpty) return const RTEmptyWidget();

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
            openDetails: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => DetailsScreen.create(
                    restaurantId: model!.restaurantsList[index].id,
                  ),
                ),
              );
            },
            onFinishNavigation: () => model!.loadFavorites(),
          );
        },
      ),
    );
  }
}
