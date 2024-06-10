import 'package:flutter/material.dart';
import 'package:restaurantour/core/dependecy_injection.dart';
import 'package:restaurantour/features/restaurant/restaurant.dart';

void main() {
  initDependencies();
  initRestaurantDependecies();
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RestaurantListPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Restaurantour'),
            ElevatedButton(
              child: const Text('Fetch Restaurants'),
              onPressed: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
