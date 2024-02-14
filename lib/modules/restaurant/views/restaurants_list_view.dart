import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/restaurant.dart';
import '../../../repositories/yelp_repository.dart';
import '../../../widgets/restaurant_card_widget.dart';
import '../view_models/restaurant_view_model.dart';
import 'restaurant_detail_view.dart';

class RestaurantsListView extends StatelessWidget {
  const RestaurantsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => RestaurantViewModel(yelpRepo: YelpRepository()),
      onViewModelReady: (RestaurantViewModel viewModel) => viewModel.ready(),
      builder: (context, RestaurantViewModel viewModel, child) =>
          FutureBuilder<List<Restaurant>>(
        future: viewModel.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data![index];
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
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return const Center(
            child: Text('Press a button to start fetching data'),
          );
        },
      ),
    );
  }
}
