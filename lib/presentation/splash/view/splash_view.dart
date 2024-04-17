import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/presentation/restaurant_list/views/views.dart';
import 'package:restaurantour/presentation/splash/widgets/widgets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const RestaurantListPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      body: const Center(
        child: SizedBox(
          height: 500,
          width: double.maxFinite,
          child: SplashAnimationWidget(),
        ),
      ),
    );
  }
}
