import 'package:flutter/material.dart';
import 'package:restaurantour/Modules/Home/view/home_injection.dart';

void main() async {
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RestauranTour',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeInjection(),
    );
  }
}
