import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/blocs/blocs.dart';
import 'package:restaurantour/ui/ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantsCubit, RestaurantsState>(
      listenWhen: (previous, current) => previous.failure != current.failure,
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
    Tab(child: Text(StringValues.allRestaurants)),
    Tab(child: Text(StringValues.myFavorites)),
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
        title: const Text(StringValues.title),
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
            children: const [
              _AllRestaurants(key: Key('all_restaurants_tab')),
              _FavoritesRestaurants(key: Key('favorites_restaurants_tab')),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        title: StringValues.emptyRestaurants,
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
              onTap: () => RestaurantDetailsPage.route(
                context,
                restaurantUi: restaurants[index],
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
          isLoadingMore ? StringValues.loading : StringValues.viewMore,
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
        title: StringValues.emptyFavorites,
      );
    }

    return ListView.builder(
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
          onTap: () => RestaurantDetailsPage.route(
            context,
            restaurantUi: favorites[index],
          ),
        );
      },
    );
  }
}
