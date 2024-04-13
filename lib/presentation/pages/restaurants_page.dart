import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';
import 'package:restaurantour/presentation/widgets/restaurant_tile.dart';

class RestaurantsPage extends StatelessWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('RestauranTour'),
            bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: 'All Restaurants'),
                Tab(text: 'My Favorites'),
              ],
            ),
          ),
          body: DefaultTabController(
            length: 2,
            child: TabBarView(
              children: [
                BlocBuilder<RestaurantsBloc, RestaurantsState>(
                  builder: (context, state) {
                    if (state is RestaurantsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is RestaurantsEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('RestauranTour'),
                            ElevatedButton(
                              child: const Text('Fetch Restaurants!'),
                              onPressed: () async {
                                context
                                    .read<RestaurantsBloc>()
                                    .add(const FetchRestaurants("Las Vegas"));
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is RestaurantsLoaded) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(6),
                                itemCount: state.restaurants.length,
                                itemBuilder: (context, index) {
                                  final restaurant = state.restaurants[index];
                                  return RestaurantTile(restaurant: restaurant);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(child: Text('Error'));
                  },
                ),
                const Center(child: Text('Favorites')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
