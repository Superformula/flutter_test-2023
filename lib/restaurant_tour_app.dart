import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/presentation/restaurant_detail/views/views.dart';
import 'package:restaurantour/presentation/restaurant_list/views/views.dart';
import 'package:restaurantour/presentation/splash/view/view.dart';

class RestauranTourApp extends StatelessWidget {
  const RestauranTourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => const SplashPage(),
        Routes.restaurantList: (context) => const RestaurantListPage(),
        Routes.restaurantDetail: (context) => const RestaurantDetailPage(),
      },
    );
  }
}
