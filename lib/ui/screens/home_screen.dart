import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/blocs/blocs.dart';
import 'package:restaurantour/di/injection.dart';

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
          // TODO: implement listener
        },
        builder: (context, state) {
          final body = state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  controller: _tabController,
                  children: const [
                    Text('All Restaurants'),
                    Text('My Favorites'),
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
