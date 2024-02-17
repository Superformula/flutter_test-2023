import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/features/home_page/presenter/bloc/home_bloc.dart';
import 'package:restaurantour/features/home_page/presenter/page/home_page.dart';
import 'package:restaurantour/features/restaurant_page/presenter/page/restaurant_page.dart';
import 'package:restaurantour/features/splash_screen/presenter/page/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider<HomeBloc>(
          create: (_) =>
              HomeBloc(hiveHelper: HiveHelper())..add(const InitialEvent()),
          child: const HomePage(),
        );
      },
    ),
    GoRoute(
      path: '/restaurant-page',
      name: 'restaurant-page',
      builder: (BuildContext context, GoRouterState state) {
        final Restaurant restaurant = state.extra as Restaurant;
        return RestaurantPage(restaurant: restaurant);
      },
    ),
  ],
);
