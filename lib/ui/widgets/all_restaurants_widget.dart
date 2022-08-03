import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/bloc/restaurants/restaurants_bloc.dart';
import 'package:restaurantour/ui/widgets/restaurant_list_tile.dart';

import '../../bloc/restaurants/restaurants_event.dart';
import '../../bloc/restaurants/restaurants_state.dart';

class AllRestaurantsWidget extends StatelessWidget {
  const AllRestaurantsWidget({Key? key}) : super(key: key);

  static const circularProcessIndicator = Center(
    child: CircularProgressIndicator(),
  );

  static const noRestaurantFound = Center(
    child: Text('No restaurants found.'),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
      builder: (context, state) {
        if (state is RestaurantsLoading) {
          return circularProcessIndicator;
        } else if (state is RestaurantsLoaded) {
          if (state.restaurants.isEmpty) {
            return noRestaurantFound;
          }

          return ListView.builder(
            itemCount: state.restaurants.length + 1,
            itemBuilder: (context, index) {
              final isTheLastElement = index >= state.restaurants.length;

              // Last element is the button to fetch more restaurants.
              if (isTheLastElement) {
                final width = MediaQuery.of(context).size.width;

                final fetchMoreButton = MaterialButton(
                  height: width * 0.2,
                  child: const Text('View more'),
                  onPressed: () => context
                      .read<RestaurantsBloc>()
                      .add(FetchedMoreRestaurants()),
                );

                final fetchingMoreRestaurantsProcessIndicator = Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: circularProcessIndicator,
                );

                return (state is RestaurantsLoadedAndFetchingMore)
                    ? fetchingMoreRestaurantsProcessIndicator
                    : fetchMoreButton;
              }

              return RestaurantListTile(
                restaurant: state.restaurants[index],

              );
            },
          );
        }
        //
        return const Center(child: Text('Something went wrong!'));
      },
    );
  }

}
