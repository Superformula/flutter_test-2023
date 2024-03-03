import 'package:flutter/material.dart';
import 'package:restaurantour/dependency_injection/di_locator.dart';
import 'package:restaurantour/presentation/restaurants/restaurant_list/restaurant_list_page.dart';

void main() {
  setupLocator();
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Lora',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const RestaurantListPage(),
    );
  }
}
