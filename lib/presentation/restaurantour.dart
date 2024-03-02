import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/datasources/restaurant_local_service.dart';
import 'package:restaurantour/data/datasources/restaurant_remote_service.dart';
import 'package:restaurantour/data/repositories/restaurant_repository.dart';
import 'package:restaurantour/presentation/list/all_restaurants_list.dart';
import 'package:restaurantour/presentation/list/favorite_restaurants.dart';
import 'package:restaurantour/presentation/list/favorite_restaurants_cubit.dart';
import 'package:restaurantour/presentation/list/restaurants_cubit.dart';
import 'package:restaurantour/secrets.dart';

class RestaurantourProvider extends StatelessWidget {
  const RestaurantourProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) {
            return RestaurantLocalService();
          },
        ),
        RepositoryProvider(
          create: (_) {
            return RestaurantRemoteService(apiKey: Secrets.resolvedApiKey);
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              RepositoryProvider(
                create: (_) {
                  return RestaurantRepository(context.read(), context.read());
                },
              ),
              BlocProvider(
                create: (context) {
                  return RestaurantsCubit(context.read());
                },
              ),
              BlocProvider(
                create: (context) {
                  return FavoriteRestaurantsCubit(context.read());
                },
              ),
            ],
            child: child,
          );
        },
      ),
    );
  }
}

class Restaurantour extends StatefulWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  State<Restaurantour> createState() => _RestaurantourState();
}

class _RestaurantourState extends State<Restaurantour>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RestauranTour',
        ),
        toolbarHeight: 80,
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          tabAlignment: TabAlignment.center,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
          tabs: const [
            _Tab(label: 'All Restaurants'),
            _Tab(label: 'My Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          AllRestaurants(),
          FavoriteRestaurants(),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(label),
    );
  }
}
