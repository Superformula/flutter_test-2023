import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/common/ui/app_colors.dart';
import 'package:restaurantour/common/widgets/app_error_refresh_widget.dart';
import 'package:restaurantour/features/restaurant/presentation/cubit/restaurants_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/widgets/restaurant_list_widget.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'RestauranTour',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: const [
              Tab(
                text: 'All Restaurants',
                height: 40,
              ),
              Tab(
                text: 'My Favorites',
                height: 40,
              ),
            ],
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                width: 2.0,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).textTheme.bodyMedium?.color,
            unselectedLabelColor: AppColors.kFarquaadGray,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        body: TabBarView(
          children: [
            _buildRestaurantsWidget(),
            _buildRestaurantsWidget(showOnlyFavorites: true),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantsWidget({bool showOnlyFavorites = false}) {
    return BlocBuilder<RestaurantsCubit, RestaurantsState>(
      builder: (context, restaurantsState) {
        if (restaurantsState is RestaurantsLoaded) {
          return RestaurantListWidget(
            restaurants: restaurantsState.restaurants,
            favoriteRestaurants:
                showOnlyFavorites ? restaurantsState.favoriteRestaurants : null,
          );
        }

        if (restaurantsState is RestaurantsError) {
          return AppErrorRefreshWidget(
            errorMessage: restaurantsState.errorMessage,
            onRefresh: () =>
                context.read<RestaurantsCubit>().loadRestaurantsList(),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        );
      },
    );
  }
}
