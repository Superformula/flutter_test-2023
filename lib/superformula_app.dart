import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/screens/restaurant_detail_screen.dart';

import 'screens/home_screen.dart';

class SuperformulaApp extends StatelessWidget {
  const SuperformulaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superformula Test',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        RestaurantDetailScreen.id: (context) => RestaurantDetailScreen(),
      },
    );
  }
}
