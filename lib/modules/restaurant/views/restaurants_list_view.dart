import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../repositories/yelp_repository.dart';
import '../../../widgets/restaurant_card_widget.dart';
import '../view_models/restaurant_view_model.dart';
import 'restaurant_detail_view.dart';

class RestaurantsListView extends StatelessWidget {
  const RestaurantsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RestaurantViewModel>.reactive(
      viewModelBuilder: () => RestaurantViewModel(yelpRepo: YelpRepository()),
      onViewModelReady: (RestaurantViewModel viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }

        if (viewModel.errorMessage != null) {
          return Center(child: Text('Error: ${viewModel.errorMessage}'));
        }

        if (viewModel.restaurants.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: viewModel.fetchAndCacheRestaurants,
            child: ListView.builder(
              itemCount: viewModel.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = viewModel.restaurants[index];
                return InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailView(
                          restaurantIndex: index,
                          restaurant: restaurant,
                        ),
                      ),
                    ),
                  },
                  child: RestaurantCardWidget(
                    restaurantIndex: index,
                    restaurant: restaurant,
                  ),
                );
              },
            ),
          );
        }

        return Center(
          child: ElevatedButton(
            child: const Text('Fetch Restaurants'),
            onPressed: () => {viewModel.fetchAndCacheRestaurants()},
          ),
        );
      },
    );
  }
}
