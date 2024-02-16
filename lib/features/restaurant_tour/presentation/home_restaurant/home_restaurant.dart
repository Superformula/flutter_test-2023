// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/features/restaurant_tour/bloc/restaurant_bloc.dart';
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
                indicatorColor: kAccentColor,
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
            builder: (context, state) {
              return TabBarView(
                children: [
                  getAllRestaurantsWidget(state),
                  Center(
                    child: Text('Favorites'),
                  ),
                ],
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
        return Text(
          'There are not restaurants available, please try again later',
        );
      }
    } else {
      return Text(
        (state as RestaurantNotLoaded).error ??
            'Could not load the restaurants, please try again later',
      );
    }
  }
}
