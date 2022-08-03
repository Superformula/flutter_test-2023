import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/bloc/restaurants/restaurants_bloc.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/ui/widgets/restaurant_list_tile.dart';

import '../../bloc/restaurants/restaurants_event.dart';
import '../../bloc/restaurants/restaurants_state.dart';
import '../screens/restaurant_details_screen.dart';

class AllRestaurantsWidget extends StatelessWidget {
  const AllRestaurantsWidget({Key? key}) : super(key: key);

  static const circularProcessIndicator = Center(
    child: CircularProgressIndicator(),
  );

  static const noRestaurantFound = Center(
    child: Text('No restaurants found.'),
  );

  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
      builder: (context, state) {
        if (state is RestaurantsLoading) {
          return circularProcessIndicator;
        }
        //
        else if (state is RestaurantsLoaded) {
          var restaurants = state.restaurants;

          if (restaurants == null || restaurants.isEmpty) {
            return noRestaurantFound;
          }

          return ListView.builder(
            itemCount: restaurants.length + 1,
            itemBuilder: (context, index) {
              var isTheLastElement = index >= restaurants.length;

              // Last element is the button to fetch more restaurants.
              if (isTheLastElement) {
                var width = MediaQuery.of(context).size.width;

                var fetchMoreButton = MaterialButton(
                  height: width * 0.2,
                  child: const Text('View more'),
                  onPressed: () => context
                      .read<RestaurantsBloc>()
                      .add(FetchedMoreRestaurants()),
                );

                var fetchingMoreRestaurantsProcessIndicator = Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: circularProcessIndicator,
                );

                return (state is RestaurantsLoadedAndFetchingMore)
                    ? fetchingMoreRestaurantsProcessIndicator
                    : fetchMoreButton;
              }

              return RestaurantListTile(
                restaurant: restaurants[index],
                onTap: () => pushRoute(context, restaurants, index),
              );
            },
          );
        }
        //
        return const Center(child: Text('Something went wrong!'));
      },
    );
  }

  void pushRoute(
    BuildContext context,
    List<Restaurant> restaurants,
    int index,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailsScreen(
          restaurant: restaurants[index],
        ),
      ),
    );
  }
}
