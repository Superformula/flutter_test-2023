import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/api/favorite_restaurants_api.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/presenter/bloc/favorite_restaurants_bloc.dart';
import 'package:restaurantour/shared/widgets/home_loading_skeleton.dart';
import 'package:restaurantour/shared/widgets/single_restaurant_card/single_restaurant_card_export.dart';

class FavoriteRestaurantsTab extends StatelessWidget {
  const FavoriteRestaurantsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteRestaurantsBloc(
        hiveHelper: HiveHelper(),
        favoriteRestaurantsRepository: FavoriteRestaurantsApi(),
      )..add(
          const InitialEvent(),
        ),
      child: const _Page(),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteRestaurantsBloc, FavoriteRestaurantsState>(
      listener: (context, state) {
        if (state is FavErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong, please come back later.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteRestaurantsBloc, FavoriteRestaurantsState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const CardsLoadingSkeleton();
        }
        if (state is FavoriteRestaurantsLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8.0),
            itemCount: state.favoriteList.length,
            itemBuilder: (context, index) {
              final restaurant = state.favoriteList[index];
              final parseRestaurant = Restaurant.fromJson(restaurant.toJson());
              final int delay = index * 500;
              return FadeInRight(
                child: SingleRestaurantCard(
                  isFromFavorites:true,
                  restaurant: parseRestaurant,
                ),
                delay: Duration(milliseconds: delay),
              );
            },
          );
        }
        if (state is NoFavoritesState) {
          return const Center(
            child: Text(
              'No favorite restaurantes were added',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        } else {
          return const Text('No data found');
        }
      },
    );
  }
}
