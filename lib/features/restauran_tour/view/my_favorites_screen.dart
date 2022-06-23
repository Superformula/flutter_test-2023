import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/app_routes/app_routes.dart';
import 'package:restaurantour/features/restauran_tour/model/restaurant.dart';
import 'package:restaurantour/features/restauran_tour/view/restaurant_row_item.dart';
import 'package:restaurantour/features/restauran_tour/view_model/restaurants_view_model.dart';

class MyFavoritesScreen extends StatelessWidget {
  const MyFavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantsViewModel viewModel = context.watch<RestaurantsViewModel>();
    List<Restaurant> favoriteList = viewModel.getFavoriteList();
    if (favoriteList.isNotEmpty) {
      return ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (BuildContext context, int index) {
          return RestaurantRowItem(
            restaurant: favoriteList[index],
            onTapItem: () {
              viewModel.setSelectedRestaurant(favoriteList[index]);
              Navigator.pushNamed(context, AppRoutes.restaurantDetailRoute);
            },
          );
        },
      );
    } else {
      return Center(
        child: Text(
          "No items added as favorites",
          style: Theme.of(context).textTheme.headline6,
        ),
      );
    }
  }
}
