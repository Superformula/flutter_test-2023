import 'package:flutter/material.dart';
import 'package:restaurantour/main_app.dart';
import 'package:restaurantour/theme/app_theme.dart';

void main() {
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: AppTheme.themeData,
      home: const MainApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
