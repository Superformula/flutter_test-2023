import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/blocs/blocs.dart';
import 'package:restaurantour/ui/models/restaurant_ui.dart';
import 'package:restaurantour/ui/router.dart';
import 'package:restaurantour/ui/screens/home/widgets/widgets.dart';
import 'package:restaurantour/ui/values/padding_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _tabs = const [
    Tab(child: Text('All Restaurants')),
    Tab(child: Text('My Favorites')),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsCubit, RestaurantsState>(
      listener: (context, state) {
        state.failure.fold(
          () {},
          (f) {
            final message = f.when(
              serverError: () => 'Server error',
              unauthorized: () => 'Unauthorized',
              unexpected: () => 'An unexpected error has occurred',
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          },
        );
      },
      builder: (context, state) {
        final body = state.isLoading && state.restaurants.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _tabController,
                children: [
                  _AllRestaurants(
                    restaurants: state.restaurants,
                    isLoading: state.isLoading,
                    hasMore: state.hasMore,
                  ),
                  _FavoritesRestaurants(restaurants: state.favorites),
                ],
              );

        return Scaffold(
          appBar: AppBar(
            title: const Text('RestauranTour'),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: _tabs,
            ),
          ),
          body: body,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class _AllRestaurants extends StatelessWidget {
  final List<RestaurantUi> restaurants;
  final bool isLoading;
  final bool hasMore;

  const _AllRestaurants({
    Key? key,
    required this.restaurants,
    required this.isLoading,
    required this.hasMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: PaddingValues.l,
        horizontal: PaddingValues.big,
      ),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index].restaurant;
        final isLastItem = index == restaurants.length - 1;

        return Column(
          children: [
            RestaurantListTile(
              title: restaurant.name,
              category: restaurant.displayCategory,
              image: restaurant.heroImage,
              isOpen: restaurant.isOpen,
              rating: restaurant.rating,
              price: restaurant.price,
              onTap: () => GoRouter.of(context).pushNamed(
                RouteName.restaurantDetails,
                extra: restaurants[index],
              ),
            ),
            if (isLastItem && hasMore)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => context.read<RestaurantsCubit>().getRestaurants(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: PaddingValues.l,
                    bottom: PaddingValues.xxl,
                  ),
                  child: Text(
                    isLoading ? 'Loading...' : 'View more',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _FavoritesRestaurants extends StatelessWidget {
  final List<RestaurantUi> restaurants;

  const _FavoritesRestaurants({Key? key, required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.favorite_border, size: 62),
          SizedBox(height: PaddingValues.l),
          Text('No favorite restaurants yet'),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: PaddingValues.l,
        horizontal: PaddingValues.big,
      ),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index].restaurant;

        return RestaurantListTile(
          title: restaurant.name,
          category: restaurant.displayCategory,
          image: restaurant.heroImage,
          isOpen: restaurant.isOpen,
          rating: restaurant.rating,
          price: restaurant.price,
          onTap: () => GoRouter.of(context).pushNamed(
            RouteName.restaurantDetails,
            extra: restaurants[index],
          ),
        );
      },
    );
  }
}
