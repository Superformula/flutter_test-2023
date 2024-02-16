import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/features/home_page/presenter/page/home_page.dart';
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
        return const HomePage();
      },
    ),
  ],
);
