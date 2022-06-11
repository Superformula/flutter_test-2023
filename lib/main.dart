import 'package:flutter/material.dart';
import 'package:restaurantour/list_view/list_view_main.dart';
import 'package:restaurantour/theme/app_theme.dart';

void main() {
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: AppTheme.themeData,
      home: const ListViewMain(),
      debugShowCheckedModeBanner: false,
    );
  }
}
