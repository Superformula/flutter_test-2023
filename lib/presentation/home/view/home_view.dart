import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/home/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: RestaurantsList(),
      ),
    );
  }
}
