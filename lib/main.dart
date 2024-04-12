import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:restaurantour/screens/restaurants_screen.dart';
import 'package:restaurantour/theme/main_theme.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Ensure flutter before loading .env file
  await dotenv.load(); //Load the sensitive data with .env
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      home: const RestaurantListScreen(),
      theme: MainTheme.mainTheme,
    );
  }
}
