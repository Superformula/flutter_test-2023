import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/app_routes/app_routes.dart';
import 'package:restaurantour/features/restauran_tour/view/restaurant_row_item.dart';
import 'package:restaurantour/features/restauran_tour/view_model/restaurants_view_model.dart';
import 'package:restaurantour/theme/app_color.dart';
import 'package:restaurantour/widgets/load_more_button.dart';

class AllRestaurantsScreen extends StatelessWidget {
  const AllRestaurantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantsViewModel viewModel = context.watch<RestaurantsViewModel>();
    if (viewModel.loading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryFill),
        ),
      );
    }
    return ListView.builder(
      itemCount: viewModel.allRestaurants.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return (index == viewModel.allRestaurants.length)
            ? _viewMoreButton(context, viewModel)
            : RestaurantRowItem(
                restaurant: viewModel.allRestaurants[index],
                onTapItem: () {
                  viewModel
                      .setSelectedRestaurant(viewModel.allRestaurants[index]);
                  Navigator.pushNamed(context, AppRoutes.restaurantDetailRoute);
                },
              );
      },
    );
  }

  Widget _viewMoreButton(BuildContext context, RestaurantsViewModel viewModel) {
    return (viewModel.allRestaurants.length == viewModel.totalRestaurantsCount)
        ? const IgnorePointer()
        : LoadMoreButton(
            onLoadMoreTap: viewModel.loadMore,
          );
  }
}
