import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';
import 'package:restaurantour/presentation/all_restaurants_list.dart';
import 'package:restaurantour/presentation/restaurants_cubit.dart';
import 'package:restaurantour/secrets.dart';

class RestaurantourProvider extends StatelessWidget {
  const RestaurantourProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (_) {
            return YelpRepository(apiKey: Secrets.resolvedApiKey);
          },
        ),
        BlocProvider(
          create: (context) {
            return RestaurantsCubit(context.read());
          },
        ),
      ],
      child: child,
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
        backgroundColor: Colors.white,
        title: const Text(
          'RestauranTour',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          tabAlignment: TabAlignment.center,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
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
          AllRestaurants(),
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
