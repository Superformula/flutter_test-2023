import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/typography/restaurantour_text_styles.dart';
import '../controllers/home/home_cubit.dart';
import '../controllers/home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  HomeCubit get cubit => context.read<HomeCubit>();

  @override
  void initState() {
    super.initState();
    cubit.fetchRestaurants();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'RestauranTour',
              style: RestaurantourTextStyles.h6,
            ),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'All Restaurants',
                    style: RestaurantourTextStyles.body,
                  ),
                ),
                Tab(
                  child: Text(
                    'Favortie Restaurants',
                    style: RestaurantourTextStyles.body,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state.status) {
                  case HomeStatus.initial:
                    return const Center(
                      child: SizedBox.shrink(),
                    );
                  case HomeStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case HomeStatus.success:
                    return const Center(
                      child: Text('success'),
                    );

                  case HomeStatus.failure:
                    return Center(
                      child: Text(state.errorMessage),
                    );
                }
              },
            ),
          ),
        ),
      );
}
