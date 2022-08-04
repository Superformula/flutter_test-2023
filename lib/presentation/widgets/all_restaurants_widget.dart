import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/restaurants/restaurants_bloc.dart';
import '../../business_logic/bloc/restaurants/restaurants_event.dart';
import '../../business_logic/bloc/restaurants/restaurants_state.dart';
import '../../presentation/widgets/restaurant_list_tile.dart';

class AllRestaurantsWidget extends StatelessWidget {
  const AllRestaurantsWidget({Key? key}) : super(key: key);

  static const circularProcessIndicator = Center(
    child: CircularProgressIndicator(),
  );

  static const viewMoreButtonText = 'View more';
  static const noRestaurantFoundText = 'No restaurants found.';
  static const somethingWrongText = 'Something went wrong!';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
      builder: (_, state) {
        if (state is RestaurantsLoadInProgress) {
          return circularProcessIndicator;
        } else if (state is RestaurantsLoadSuccess) {
          if (state.restaurants.isEmpty) {
            return const Center(child: Text(noRestaurantFoundText));
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
                  child: const Text(viewMoreButtonText),
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
                key: Key(state.restaurants[index].id!),
              );
            },
          );
        }
        //
        return const Center(child: Text(somethingWrongText));
      },
    );
  }
}
