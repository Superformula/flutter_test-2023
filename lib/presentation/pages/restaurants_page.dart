import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';

class RestaurantsPage extends StatelessWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Restaurantour'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Restaurants'),
                Tab(text: 'Favorites'),
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
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Restaurantour'),
                          ElevatedButton(
                            child: const Text('Fetch Restaurants!'),
                            onPressed: () async {
                              context
                                  .read<RestaurantsBloc>()
                                  .add(const FetchRestaurants("Las Vegas"));
                            },
                          ),
                          if (state is RestaurantsLoaded)
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.restaurants.length,
                                itemBuilder: (context, index) {
                                  final restaurant = state.restaurants[index];
                                  return ListTile(
                                    title: Text(restaurant.name!),
                                    subtitle: Text(
                                      restaurant.location!.formattedAddress!,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    );
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
