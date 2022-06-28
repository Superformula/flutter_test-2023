import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/blocs/blocs.dart';
import 'package:restaurantour/data/data.dart';
import 'package:restaurantour/di/injection.dart';
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
    return BlocProvider(
      create: (context) => getIt<RestaurantsCubit>()..getRestaurants(),
      child: BlocConsumer<RestaurantsCubit, RestaurantsState>(
        listener: (context, state) {
          state.failure.fold(
            () {},
            (a) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('An unexpected error has occurred')),
            ),
          );
        },
        builder: (context, state) {
          final body = state.isLoading && state.restaurants.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _AllRestaurants(restaurants: state.restaurants),
                    const Text('My Favorites'),
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class _AllRestaurants extends StatelessWidget {
  final List<Restaurant> restaurants;
  const _AllRestaurants({Key? key, required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: PaddingValues.l,
        horizontal: PaddingValues.big,
      ),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];

        return Column(
          children: [
            RestaurantListTile(
              title: restaurant.name,
              category: restaurant.displayCategory,
              image: restaurant.heroImage,
              isOpen: restaurant.isOpen,
              rating: restaurant.rating,
              price: restaurant.price,
              onTap: () => GoRouter.of(context)
                  .pushNamed(RouteName.restaurantDetails, extra: restaurant),
            ),
            if (index == restaurants.length - 1)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => context.read<RestaurantsCubit>().getRestaurants(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: PaddingValues.l,
                    bottom: PaddingValues.xxl,
                  ),
                  child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
                    buildWhen: (previous, current) =>
                        previous.isLoading != current.isLoading,
                    builder: (context, state) {
                      return Text(
                        state.isLoading ? 'Loading...' : 'View more',
                        style: Theme.of(context).textTheme.button,
                      );
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
