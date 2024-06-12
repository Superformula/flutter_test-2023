import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/controllers/favorite/favorite_cubit.dart';
import 'package:restaurantour/presentation/controllers/favorite/favorite_state.dart';
import 'package:restaurantour/presentation/pages/favorites_page.dart';

import '../../utils/typography/restaurantour_text_styles.dart';
import '../controllers/home/home_cubit.dart';
import '../controllers/home/home_state.dart';
import '../widgets/restaurant_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  HomeCubit get cubit => context.read<HomeCubit>();
  FavoriteCubit get favoriteCubit => context.read<FavoriteCubit>();

  @override
  void initState() {
    super.initState();
    cubit.fetchRestaurants();
  }

  @override
  void dispose() {
    cubit.close();
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
                    'Favorite Restaurants',
                    style: RestaurantourTextStyles.body,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case HomeStatus.initial:
                        return const SizedBox.shrink();
                      case HomeStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case HomeStatus.success:
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ListView.builder(
                            itemCount: state.restaurants.length,
                            itemBuilder: (context, index) =>
                                RestaurantCardWidget(
                              favoriteCubit: favoriteCubit,
                              restaurant: state.restaurants[index],
                            ),
                          ),
                        );

                      case HomeStatus.failure:
                        return Center(
                          child: Text(state.errorMessage),
                        );
                    }
                  },
                ),
                BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case FavoriteStatus.initial:
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 48,
                            ),
                            Text(
                              'You have not added any favorite resaturants!',
                            ),
                          ],
                        );
                      case FavoriteStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case FavoriteStatus.success:
                        return FavoritesPage(
                          restaurants: state.favorites,
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
