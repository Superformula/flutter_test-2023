import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/home/state_management/home_tab_controller_cubit/home_tab_controller_cubit.dart';
import 'package:restaurantour/presentation/home/widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      animationDuration: const Duration(milliseconds: 350),
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
        bottom: false,
        child: BlocListener<HomeTabControllerCubit, HomeTabControllerState>(
          listener: (context, state) {
            state.when(
              allRestaurants: () => _tabController.animateTo(0),
              myFavorites: () => _tabController.animateTo(1),
            );
          },
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: const [
              RestaurantsList(),
              FavoritesList(),
            ],
          ),
        ),
      ),
    );
  }
}
