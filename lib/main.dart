import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/restaurantour.dart';
import 'package:restaurantour/secrets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Secrets.init();
  runApp(const RestaurantourApp());
}

class RestaurantourApp extends StatelessWidget {
  // This widget is the root of your application.
  const RestaurantourApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RestaurantourProvider(child: Restaurantour()),
    );
  }
}
