import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/dependency_injection/di_locator.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/view/restaurants/restaurant_detail/restaurant_detail_page.dart';
import 'package:restaurantour/design_system/restaurant_list_tile.dart';
import 'package:restaurantour/view/restaurants/restaurant_list/restaurant_list_view_model.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant List'),
          bottom: const TabBar(
            labelStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
            ),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'All Restaurants',
              ),
              Tab(
                text: 'My Favorites',
              ),
            ],
          ),
        ),
        body: ChangeNotifierProvider<RestaurantListViewModel>(
          create: (context) => locator<RestaurantListViewModel>()..init(),
          builder: (context, child) {
            return Consumer<RestaurantListViewModel>(
              builder: (context, viewModel, child) {
                return const TabBarView(
                  children: [
                    _AllRestaurantsTab(),
                    _MyFavoritesTab(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AllRestaurantsTab extends StatelessWidget {
  const _AllRestaurantsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RestaurantListViewModel>(context);

    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (viewModel.hasError) {
      return const Center(
        child: Text(
          'Oops, unable to fetch restaurants. Try again later.',
        ),
      );
    }
    final restaurants = viewModel.restaurants;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          viewModel.getRestaurants();
          return true;
        }
        return false;
      },
      child: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final RestaurantEntity restaurant = viewModel.restaurants[index];
          return RestaurantListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailPage(
                    // Pass necessary data to the detail page
                    restaurant: restaurant,
                  ),
                ),
              );
            },
            imageUrl: restaurant.heroImage,
            name: restaurant.name,
            priceRange: restaurant.price,
            rating: restaurant.rating,
            isOpen: restaurant.isOpen,
            category: restaurant.category,
          );
        },
      ),
    );
  }
}

class _MyFavoritesTab extends StatelessWidget {
  const _MyFavoritesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RestaurantListViewModel>();

    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (viewModel.hasError) {
      return const Center(
        child: Text(
          'Oops, unable to fetch restaurants. Try again later.',
        ),
      );
    }

    final favoriteRestaurants = viewModel.restaurants
        .where((restaurant) =>
            viewModel.favoriteRestaurants.contains(restaurant.id))
        .toList();

    if (favoriteRestaurants.isEmpty) {
      return const Center(
        child: Text(
          'You have no favorite restaurants yet.',
        ),
      );
    }
    return ListView.builder(
      itemCount: favoriteRestaurants.length,
      itemBuilder: (context, index) {
        final RestaurantEntity restaurant = favoriteRestaurants[index];
        return RestaurantListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantDetailPage(
                  // Pass necessary data to the detail page
                  restaurant: restaurant,
                ),
              ),
            );
          },
          imageUrl: restaurant.heroImage,
          name: restaurant.name,
          priceRange: restaurant.price,
          rating: restaurant.rating,
          isOpen: restaurant.isOpen,
          category: restaurant.category,
        );
      },
    );
  }
}
