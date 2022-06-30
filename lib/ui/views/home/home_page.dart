import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/blocs/blocs.dart';
import 'package:restaurantour/ui/router/router.dart';
import 'package:restaurantour/ui/values/padding_values.dart';
import 'package:restaurantour/ui/views/home/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantsCubit, RestaurantsState>(
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
              ..clearSnackBars()
              ..showSnackBar(SnackBar(content: Text(message)));
          },
        );
      },
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestauranTour'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs,
        ),
      ),
      body: BlocBuilder<RestaurantsCubit, RestaurantsState>(
        buildWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            controller: _tabController,
            children: const [_AllRestaurants(), _FavoritesRestaurants()],
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
  const _AllRestaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurants =
        context.select((RestaurantsCubit cubit) => cubit.state.restaurants);
    final hasMore =
        context.select((RestaurantsCubit cubit) => cubit.state.hasMore);

    if (restaurants.isEmpty) {
      return const EmptySection(
        icon: Icons.store,
        title: 'There are no restaurants',
      );
    }

    return ListView.builder(
      key: const Key('homeBody_all_restaurants'),
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
            if (isLastItem && hasMore) const _Pagination(),
          ],
        );
      },
    );
  }
}

class _Pagination extends StatelessWidget {
  const _Pagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoadingMore =
        context.select((RestaurantsCubit cubit) => cubit.state.isLoadingMore);

    final onTap = !isLoadingMore
        ? () => context.read<RestaurantsCubit>().getRestaurants()
        : null;

    return GestureDetector(
      key: const Key('allRestaurants_pagination'),
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: PaddingValues.l,
          bottom: PaddingValues.xxl,
        ),
        child: Text(
          isLoadingMore ? 'Loading...' : 'View more',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}

class _FavoritesRestaurants extends StatelessWidget {
  const _FavoritesRestaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites =
        context.select((RestaurantsCubit cubit) => cubit.state.favorites);

    if (favorites.isEmpty) {
      return const EmptySection(
        icon: Icons.favorite_border,
        title: 'No favorite restaurants yet',
      );
    }

    return ListView.builder(
      key: const Key('homeBody_favorites_restaurants'),
      padding: const EdgeInsets.symmetric(
        vertical: PaddingValues.l,
        horizontal: PaddingValues.big,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final restaurant = favorites[index].restaurant;

        return RestaurantListTile(
          title: restaurant.name,
          category: restaurant.displayCategory,
          image: restaurant.heroImage,
          isOpen: restaurant.isOpen,
          rating: restaurant.rating,
          price: restaurant.price,
          onTap: () => GoRouter.of(context).pushNamed(
            RouteName.restaurantDetails,
            extra: favorites[index],
          ),
        );
      },
    );
  }
}
