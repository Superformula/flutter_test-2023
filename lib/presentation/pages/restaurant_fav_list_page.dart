import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';
import 'package:restaurantour/presentation/pages/widgets/custom_progress_indicator.dart';
import 'package:restaurantour/presentation/pages/widgets/restaurant_card.dart';

class RestaurantFavListWidget extends StatelessWidget {
  const RestaurantFavListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
          builder: (context, state) {
            if (state is RestaurantsEmpty) {
              return Container();
            }
            if (state is RestaurantsLoading) {
              return const Center(child: CustomProgressIndicator());
            }
            if (state is RestaurantsLoadFail) {
              return Column(
                children: [
                  const Center(
                    key: Key('error'),
                    child: Text('Error'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    onPressed: () => context
                        .read<RestaurantsBloc>()
                        .add(const OnRequestedRestaurants()),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              );
            }
            if (state is RestaurantsLoaded) {
              if (state.favouritesList.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.favouritesList.length,
                  itemBuilder: (context, index) {
                    return RestaurantListCard(
                      restaurantEntity: state.result[index],
                    );
                  },
                );
              }
              return const Center(
                  child: Text("You don´t have any favourites added"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
