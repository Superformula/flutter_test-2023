import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';
import 'package:restaurantour/presentation/widgets/restaurant_tile.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestauranTour'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: 'All Restaurants'),
            Tab(text: 'My Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
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
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 6,
                    right: 6,
                    bottom: 100,
                  ),
                  itemCount: state.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = state.restaurants[index];
                    return RestaurantTile(restaurant: restaurant);
                  },
                );
              }
              return const Center(child: Text('Error'));
            },
          ),
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
                var favs =
                    state.restaurants.where((r) => r.isFavorite!).toList();
                if (favs.isEmpty) {
                  return const Center(child: Text('No favorites yet'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 6,
                    right: 6,
                    bottom: 100,
                  ),
                  itemCount: favs.length,
                  itemBuilder: (context, index) {
                    final restaurant = favs[index];
                    return RestaurantTile(restaurant: restaurant);
                  },
                );
              }
              return const Center(child: Text('Error'));
            },
          ),
        ],
      ),
    );
  }
}
