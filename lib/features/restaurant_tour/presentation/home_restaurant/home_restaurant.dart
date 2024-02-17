// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/features/restaurant_tour/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:restaurantour/features/restaurant_tour/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:restaurantour/features/restaurant_tour/models/restaurant.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/restaurant_card.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/restaurant_card_shimmer.dart';
import 'package:restaurantour/theme/style.dart';

class HomeResturant extends StatelessWidget {
  const HomeResturant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                'RestaurantTour',
                style: titleStyle,
              ),
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Center(
              child: TabBar(
                tabAlignment: TabAlignment.center,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: defaultTextColor,
                labelStyle: buttonStyle,
                indicatorColor: accentColor,
                unselectedLabelColor: secondaryTextColor,
                unselectedLabelStyle: buttonStyle,
                tabs: [
                  Tab(
                    text: "All Restaurants",
                  ),
                  Tab(
                    text: "My Favorites",
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 2.5,
        ),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: BlocBuilder<RestaurantBloc, RestaurantState>(
            builder: (context, restaurantState) {
              return BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favoritesState) {
                  return TabBarView(
                    children: [
                      getAllRestaurantsWidget(restaurantState),
                      getFavoritesWidget(favoritesState),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getAllRestaurantsWidget(RestaurantState state) {
    if (state is RestaurantLoading) {
      return ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: RestaurantCardShimmer(),
          );
        }),
      );
    } else if (state is RestaurantLoaded) {
      if (state.restaurants?.isNotEmpty ?? false) {
        final List<Restaurant> restaurants = state.restaurants!;
        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: RestaurantCard(restaurant: restaurants[index]),
            );
          }),
        );
      } else {
        return Center(
          child: Text(
            'There are not restaurants available, please try again later',
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        );
      }
    } else {
      return Center(
        child: Text(
          (state as RestaurantNotLoaded).error ??
              'Could not load the restaurants, please try again later',
          style: titleStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}

Widget getFavoritesWidget(FavoritesState state) {
  if (state is FavoritesLoading) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: RestaurantCardShimmer(),
        );
      }),
    );
  } else if (state is FavoritesLoaded) {
    if (state.favoritesRestaurants.isNotEmpty) {
      final List<Restaurant> restaurants = state.favoritesRestaurants;
      return ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: RestaurantCard(restaurant: restaurants[index]),
          );
        }),
      );
    } else {
      return Center(
        child: Text(
          "You don't have any favorite restaurants added yet",
          style: titleStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
  } else {
    return Center(
      child: Text(
        (state as FavoritesNotLoaded).error ??
            'Could not load your favorite restaurants, please try again later',
        style: titleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
