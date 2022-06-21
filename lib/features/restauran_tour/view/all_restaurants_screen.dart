import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/app_routes/app_routes.dart';
import 'package:restaurantour/features/restauran_tour/view/restaurant_row_item.dart';
import 'package:restaurantour/features/restauran_tour/view_model/restaurants_view_model.dart';

class AllRestaurantsScreen extends StatelessWidget {
  const AllRestaurantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantsViewModel viewModel = context.watch<RestaurantsViewModel>();
    return ListView.builder(
      itemCount: viewModel.allRestaurants.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == viewModel.allRestaurants.length) {
          if (viewModel.allRestaurants.length ==
              viewModel.totalRestaurantsCount) {
            return const IgnorePointer();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: TextButton(
              onPressed: () {
                viewModel.loadMore();
              },
              child: Text(
                "View More",
                style: Theme.of(context).textTheme.button,
              ),
            ),
          );
        }
        return RestaurantRowItem(
          restaurant: viewModel.allRestaurants[index],
          onTapItem: () {
            viewModel.setSelectedRestaurant(viewModel.allRestaurants[index]);
            Navigator.pushNamed(context, AppRoutes.restaurantDetailRoute);
          },
        );
      },
    );
  }
}
