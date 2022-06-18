import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_theme.dart';
import 'package:restaurantour/restauran_tour.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: const RestauranTour(),
    );
  }
}
